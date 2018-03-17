require 'test_helper'

class LecturesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @lecture = lectures(:two)
    @course = courses(:two)
    @student_user = users(:billy)
    @teacher_user = users(:ben)
    @school_admin = users(:daniel)
    @global_admin = users(:admin)
  end

  test "should show lecture" do
    log_in_as @student_user
    get lecture_path @lecture
    assert_response :success
  end

  test "student should not edit lecture" do
    log_in_as @student_user
    get edit_lecture_path @lecture
    assert_redirected_to root_url
  end

  test "teacher should edit and update lecture" do
    log_in_as @teacher_user
    get edit_lecture_path @lecture
    assert_response :success
    patch lecture_path(@lecture), params: { lecture: { description: "New Lorem Ipsum" } }
    assert_redirected_to @lecture
    assert_equal "New Lorem Ipsum", @lecture.reload.description
  end

  test "school admin should create new lecture" do
    log_in_as @school_admin
    get new_lecture_path
    assert_response :success
    assert_difference "Lecture.count", 1 do
      post lectures_path, params: { lecture: { description: "Lorem Ipsum",
                                             location: "1A",
                                             course_id: @course.id,
                                             starts_at: 2.days.ago,
                                             ends_at: 2.days.since } }
    end
  end

  test "global admin should create new lecture" do
    log_in_as @global_admin
    get new_lecture_path
    assert_response :success
    assert_difference "Lecture.count", 1 do
      post lectures_path, params: { lecture: { description: "New Lecture",
                                             location: "1A",
                                             course_id: @course.id,
                                             starts_at: 2.days.ago,
                                             ends_at: 2.days.since } }
    end
  end

  test "unauthorized should not create lecture" do
    log_in_as @student_user
    assert_no_difference "Lecture.count" do
      # With valid course id
      post lectures_path, params: { lecture: { description: "New Lecture",
                                             location: "1A",
                                             course_id: @course.id,
                                             starts_at: 2.days.ago,
                                             ends_at: 2.days.since } }
      # Without course id
      post lectures_path, params: { lecture: { description: "New Lecture",
                                             location: "1A",
                                             starts_at: 2.days.ago,
                                             ends_at: 2.days.since } }
    end
  end
end
