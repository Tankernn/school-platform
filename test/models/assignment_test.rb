require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  def setup
    @assignment = assignments(:one)
  end

  test "should be valid" do
    assert @assignment.valid?
  end

  test "date should be present" do
    @assignment.due_at = nil
    assert_not @assignment.valid?
  end
end
