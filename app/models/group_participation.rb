class GroupParticipation < ApplicationRecord
  belongs_to :user
  belongs_to :group, polymorphic: true

  validates :user_id, presence: true
  validates :group_id, presence: true
end
