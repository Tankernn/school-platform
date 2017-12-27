class Conversation < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }

  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :messages

  has_many :conversation_participations, dependent: :destroy

  has_many :users, through: :conversation_participations
end
