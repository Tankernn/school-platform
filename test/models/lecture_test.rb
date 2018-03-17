require 'test_helper'

class LectureTest < ActiveSupport::TestCase
  def setup
    @lecture = lectures(:one)
  end

  test "should be valid" do
    assert @lecture.valid?
  end

  test "dates should be in order" do
    @lecture.starts_at = 1.hours.ago
    @lecture.ends_at = 2.hours.ago
    assert_not @lecture.valid?
  end
end
