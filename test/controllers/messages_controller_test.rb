require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:daniel)
    @conversation = conversations(:one)
    @unallowed_conversation = conversations(:two)
    log_in_as @user
  end

  test "should create valid message" do
    get conversation_path(@conversation)
    assert_response :success
    assert_difference '@user.messages.count', 1 do
      post messages_path, params: { message: { content: "Content" },
                                    conversation_id: @conversation.id }
    end
  end

  test "should redirect create message in unallowed conversation" do
    post messages_path, params: { message: { content: "Message content" },
                                  conversation_id: @unallowed_conversation.id }
    assert_redirected_to root_path
  end
end
