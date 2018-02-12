require 'test_helper'

class SchoolsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @school = schools(:two)
    @student_user = users(:billy)
    @school_admin = users(:daniel)
    @global_admin = users(:admin)
  end

  test "should show school" do
    log_in_as @student_user
    get school_path @school
    assert_response :success
  end

  test "student should not edit school" do
    log_in_as @student_user
    get edit_school_path @school
    assert_redirected_to root_url
  end

  test "school admin should edit and update school" do
    log_in_as @school_admin
    get edit_school_path @school
    assert_response :success
    patch school_path(@school), params: { school: { name: "New Name" } }
    assert_redirected_to @school
    assert_equal "New Name", @school.reload.name
  end

  test "school admin should not create new school" do
    log_in_as @school_admin
    get new_school_path
    assert_redirected_to root_url
  end

  test "global admin should create new school" do
    log_in_as @global_admin
    get new_school_path
    assert_response :success
    assert_difference "School.count", 1 do
      post schools_path, params: { school: { name: "New School" } }
    end
  end
end
