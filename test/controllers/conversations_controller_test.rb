require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:daniel)
    @other_user = users(:ben)
    log_in_as @user
  end

  test "should create valid conversation" do
    get new_conversation_path
    assert_response :success
    assert_difference '@user.conversations.count', 1 do
      post conversations_path, params: { conversation: {
                               name: "Example conversation",
                               user_ids: [@user.id, @other_user.id],
                               messages_attributes: { "0" => { content: "Content" }}}}
    end
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
