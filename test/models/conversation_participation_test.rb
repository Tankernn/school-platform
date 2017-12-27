require 'test_helper'

class ConversationParticipationTest < ActiveSupport::TestCase
  def setup
    @participation = ConversationParticipation.new(user_id: users(:daniel).id,
                                     conversation_id: conversations(:two).id)
  end

  test "should be valid" do
    assert @participation.valid?
  end

  test "should require a user_id" do
    @participation.user_id = nil
    assert_not @participation.valid?
  end

  test "should require a conversation_id" do
    @participation.conversation_id = nil
    assert_not @participation.valid?
  end
end
