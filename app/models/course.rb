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

  has_many :data_files, as: :repository

  def can_download_files?(user)
    self.users.include?(user)
  end

  def can_upload_files?(user)
    self.users.merge(CourseParticipation.teachers).include?(user)
  end

  has_many :news_posts, as: :news_feed

  def can_post_news?(user)
    self.users.merge(CourseParticipation.teachers).include?(user)
  end

  private
    def date_order
      if ends_on < starts_on
        errors.add(:ends_on, "should come after starts_on")
      end
    end
end
