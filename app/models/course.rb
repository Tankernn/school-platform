class Course < ApplicationRecord
  belongs_to :school
  validates :school_id, presence: true

  validates :name, presence: true, length: { maximum: 255 }

  validates :starts_on, presence: true
  validates :ends_on, presence: true
  validate :date_order

  has_many :course_participations, dependent: :destroy
  has_many :users, through: :course_participations

  has_many :lectures
  has_many :assignments

  private
    def date_order
      if ends_on < starts_on
        errors.add(:ends_on, "should come after starts_on")
      end
    end
end
