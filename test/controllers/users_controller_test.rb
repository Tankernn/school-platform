require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:daniel)
    log_in_as @user
  end

  test "should display age correctly" do
    get user_path @user
    assert_select ".user-age", /[A-z]+\: [0-9]+/
  end
end
