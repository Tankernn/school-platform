require 'test_helper'

class SchoolTest < ActiveSupport::TestCase

  def setup
    @school = schools(:one)
  end

  test "should be valid" do
    assert @school.valid?
  end

  test "name should be present" do
    @school.name = "       "
    assert_not @school.valid?
  end
end
