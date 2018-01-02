require 'test_helper'

class ConversationParticipationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:daniel)
    @other_user = users(:jane)
    @conversation = conversations(:one)
    @unallowed_conversation = conversations(:two)
    log_in_as @user
  end

  test "should create valid conversation participation" do
    get conversation_path @conversation
    assert_difference 'ConversationParticipation.all.count', 1 do
      post conversation_participations_path,
        params: { conversation_participation: {
          conversation_id: @conversation.id, user_id: @other_user.id
        } }
    end
    assert_redirected_to conversation_path @conversation
  end

  test "should not create invalid conversation participation" do
    assert_no_difference 'ConversationParticipation.all.count' do
      post conversation_participations_path,
        params: { conversation_participation: {
          conversation_id: @unallowed_conversation.id, user_id: @other_user.id
        } }
    end
  end
end
