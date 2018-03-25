class Assignment < ApplicationRecord
  belongs_to :course
  validates :course_id, presence: true

  validates :name, presence: true, length: { maximum: 255 }

  validates :due_at, presence: true

  default_scope { order(due_at: :asc) }
end
