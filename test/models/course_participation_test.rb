require 'test_helper'

class CourseParticipationTest < ActiveSupport::TestCase
  def setup
    @participation = course_participations(:one)
    @user = users(:daniel)
    @course = courses(:one)
  end

  test "should be valid" do
    assert @participation.valid?
  end

  test "should filter by role correctly" do
    filtered = @course.users.merge(CourseParticipation.teachers)
    assert_equal filtered, [@user]
  end
end
