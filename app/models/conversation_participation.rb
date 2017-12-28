class ConversationParticipation < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  validates :user_id, presence: true
  validates :conversation_id, presence: true

  before_save :set_viewed_at_to_now

  def set_viewed_at_to_now
    self.viewed_at = Time.now
  end
end
