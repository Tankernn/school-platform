class Lecture < ApplicationRecord
  belongs_to :course
  validates :course_id, presence: true

  validates :location, presence: true

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :date_order

  default_scope { order(starts_at: :asc) }

  private
    def date_order
      if ends_at < starts_at
        errors.add(:ends_on, "should come after starts_on")
      end
    end
end
