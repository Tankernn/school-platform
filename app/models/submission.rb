class Submission < ApplicationRecord
  belongs_to :assignment

  validates :title, presence: true, length: { maximum: 255 }

  has_many :group_participations, as: :group, dependent: :destroy
  has_many :users, through: :group_participations
end
