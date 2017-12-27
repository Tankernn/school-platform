require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:daniel)
    @other_user = users(:ben)
    log_in_as @user
  end

  test "should redirect conversation which user is not participating in" do
    get conversation_path conversations(:two)
    assert_redirected_to root_path
  end
end
