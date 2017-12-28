module MessagesHelper
  def unread_messages_count(user)
    counter = 0
    for conversation_participation in user.conversation_participations
      counter += conversation_participation.conversation.messages.select do |message|
        message.created_at > conversation_participation.viewed_at
      end.count
    end
    counter
  end
end
