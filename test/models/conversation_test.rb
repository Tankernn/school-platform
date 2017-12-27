require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  def setup
    @conversation = Conversation.new(name: "Conversation")
  end

  test "should be valid" do
    assert @conversation.valid?
  end

  test "name should be present" do
    @conversation.name = "      "
    assert_not @conversation.valid?
  end
end
