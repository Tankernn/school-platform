class Submission < ApplicationRecord
  belongs_to :assignment

  validates :title, presence: true, length: { maximum: 255 }

  has_many :group_participations, as: :group, dependent: :destroy
  has_many :users, through: :group_participations

  has_many :data_files, as: :repository

  def can_download_files?(user)
    users.include?(user) || self.assignment.course.users.merge(CourseParticipation.teachers).include?(user)
  end

  def can_upload_files?(user)
    users.include?(user)
  end
end
