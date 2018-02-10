require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:daniel)
    @other_user = users(:ben)
    @student_user = users(:billy)
    @global_admin = users(:admin)
  end

  test "should display age correctly" do
    log_in_as @user
    get user_path @user
    assert_select ".user-age", /[A-z]+\: [0-9]+/
  end

  test "should show user" do
    log_in_as @user
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    log_in_as(@user)
    patch user_url(@user), params: { user: { email: @user.email, login: @user.login } }
    assert_redirected_to user_url(@user)
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should not allow the name attribute to be edited by non-admin" do
    log_in_as(@user)
    assert_not_equal @user.name, "Wrong Name"
    patch user_path(@user), params: {
                                    user: { password:              'newpass',
                                            password_confirmation: 'newpass',
                                            name: "Wrong Name" } }
    assert_not_equal @user.reload.name, "Wrong Name"
  end

  test "should redirect edit when unauthorized" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when unauthorized" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should update name attribute when logged in as school admin" do
    log_in_as(@user)
    patch user_url(@student_user), params: { user: { name: "New Name" } }
    assert_equal "New Name", @student_user.reload.name
    assert_redirected_to user_url(@student_user)
  end

  test "should update name attribute when logged in as global admin" do
    log_in_as(@global_admin)
    patch user_url(@student_user), params: { user: { name: "New Name" } }
    assert_equal "New Name", @student_user.reload.name
    assert_redirected_to user_url(@student_user)
  end
end
