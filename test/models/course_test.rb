require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  def setup
    @course = courses(:one)
  end

  test "should be valid" do
    assert @course.valid?
  end

  test "name should be present" do
    @course.name = "        "
    assert_not @course.valid?
  end

  test "dates should be in order" do
    @course.starts_on = 1.days.ago
    @course.ends_on = 2.days.ago
    assert_not @course.valid?
  end
end
