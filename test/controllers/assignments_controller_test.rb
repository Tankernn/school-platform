require 'test_helper'

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assignment = assignments(:one)
    @course = courses(:one)
    @global_admin = users(:admin)
    log_in_as @global_admin
  end

  test "should get index" do
    get assignments_url
    assert_response :success
  end

  test "should get new" do
    get new_assignment_url
    assert_response :success
  end

  test "should create assignment" do
    assert_difference('Assignment.count') do
      post assignments_url, params: { assignment: { course_id: @course.id, name: "Lorem Ipsum", due_at: 2.days.since } }
    end

    assert_redirected_to assignment_url(Assignment.last)
  end

  test "should not create invalid assignment" do
    assert_no_difference('Assignment.count') do
      post assignments_url, params: { assignment: { course_id: @course.id, name: "Lorem Ipsum" } }
    end
  end

  test "should show assignment" do
    get assignment_url(@assignment)
    assert_response :success
  end

  test "should get edit" do
    get edit_assignment_url(@assignment)
    assert_response :success
  end

  test "should update assignment" do
    patch assignment_url(@assignment), params: { assignment: { name: "New Name" } }
    assert_redirected_to assignment_url(@assignment)
    assert_equal @assignment.reload.name, "New Name"
  end

  test "should destroy assignment" do
    assert_difference('Assignment.count', -1) do
      delete assignment_url(@assignment)
    end

    assert_redirected_to assignments_url
  end
end
