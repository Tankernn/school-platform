require 'test_helper'

class CourseParticipationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:admin)
    @student = users(:billy)
    @course = courses(:two)
    @course_participation = course_participations(:two)
    log_in_as @admin
  end

  test "should create valid course participation" do
    get course_path @course
    assert_difference 'CourseParticipation.count', 1 do
      post course_participations_path,
        params: { course_participation: {
          course_id: @course.id, user_id: @student.id
        } }
    end
    assert_redirected_to course_path @course
  end

  test "should delete course participation" do
    assert_difference 'CourseParticipation.count', -1 do
      delete course_participation_path @course_participation
    end
    assert_redirected_to course_path courses(:one)
  end
end
