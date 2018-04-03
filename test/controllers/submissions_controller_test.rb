require 'test_helper'

class SubmissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher = users(:daniel)
    @student = users(:billy)
    @assignment = assignments(:one)
    @submission = submissions(:one)
    log_in_as @teacher
  end

  test "should get index" do
    get assignment_submissions_url(@assignment)
    assert_response :success
  end

  test "should get new" do
    get new_assignment_submission_url(@assignment)
    assert_response :success
  end

  test "student should create submission" do
    log_in_as @student
    assert_difference('Submission.count') do
      post assignment_submissions_url(@assignment), params: { submission: { description: @submission.description, title: @submission.title } }
    end

    assert_redirected_to submission_url(Submission.last)
  end

  test "should show submission" do
    get submission_url(@submission)
    assert_response :success
  end

  test "student should get edit" do
    log_in_as @student
    get edit_submission_url(@submission)
    assert_response :success
  end

  test "student should update submission" do
    log_in_as @student
    patch submission_url(@submission), params: { submission: { description: @submission.description, title: @submission.title } }
    assert_redirected_to submission_url(@submission)
  end

  test "should destroy submission" do
    assert_difference('Submission.count', -1) do
      delete submission_url(@submission)
    end

    assert_redirected_to assignment_submissions_url(@assignment)
  end
end
