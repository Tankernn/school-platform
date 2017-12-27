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

  test "last message should be shown in index" do
    message = @user.messages.build(content: "Hello, world!",
                                   conversation: conversations(:one))
    message.save
    get conversations_path
    assert_match message.content, response.body
  end
end
