class CourseParticipation < ApplicationRecord
  belongs_to :course
  belongs_to :user
  validates :course_id, presence: true
  validates :user_id, presence: true

  enum role: [:student, :teacher]

  scope :teachers, -> { where(role: :teacher) }
  scope :students, -> { where(role: :student) }
end
