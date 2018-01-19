require 'test_helper'

class AdministrationTest < ActiveSupport::TestCase

  def setup
    @admin = users(:daniel)
    @school = schools(:one)
    @administration = Administration.new(user_id: @admin.id,
                                         school_id: @school.id)
  end

  test "should be valid" do
    assert @administration.valid?
  end

  test "should destroy administration when user is destroyed" do
    @administration.save
    assert_difference "@school.administrators.count", -1 do
      @admin.destroy
    end
  end

  test "should destroy administration when school is destroyed" do
    @administration.save
    assert_difference "@admin.schools_administering.count", -1 do
      @school.destroy
    end
  end
end
