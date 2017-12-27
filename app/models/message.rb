class Message < ApplicationRecord
  validates :content, presence: true

  default_scope -> { order(created_at: :asc) }

  belongs_to :user
  belongs_to :conversation
end
