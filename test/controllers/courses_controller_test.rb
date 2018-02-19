require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @course = courses(:two)
    @school = schools(:two)
    @student_user = users(:billy)
    @school_admin = users(:daniel)
    @global_admin = users(:admin)
  end

  test "should show course" do
    log_in_as @student_user
    get course_path @course
    assert_response :success
  end

  test "student should not edit course" do
    log_in_as @student_user
    get edit_course_path @course
    assert_redirected_to root_url
  end

  test "school admin should edit and update course" do
    log_in_as @school_admin
    get edit_course_path @course
    assert_response :success
    patch course_path(@course), params: { course: { name: "New Name" } }
    assert_redirected_to @course
    assert_equal "New Name", @course.reload.name
  end

  test "school admin should create new course" do
    log_in_as @school_admin
    get new_course_path
    assert_response :success
    assert_difference "Course.count", 1 do
      post courses_path, params: { course: { name: "New Course",
                                             school_id: @school.id,
                                             starts_on: 2.days.ago,
                                             ends_on: 2.days.since } }
    end
  end

  test "global admin should create new course" do
    log_in_as @global_admin
    get new_course_path
    assert_response :success
    assert_difference "Course.count", 1 do
      post courses_path, params: { course: { name: "New Course",
                                             school_id: @school.id,
                                             starts_on: 2.days.ago,
                                             ends_on: 2.days.since } }
    end
  end
end
