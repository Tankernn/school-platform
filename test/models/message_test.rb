require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @message = messages(:one)
  end

  test "should be valid" do
    assert @message.valid?
  end

  test "content should be present" do
    @message.content = "      "
    assert_not @message.valid?
  end

  test "should destroy messages on conversation destroy" do
    assert_difference "Message.all.count", -2 do
      conversations(:one).destroy
    end
  end
end
