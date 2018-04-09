class NewsPost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  belongs_to :news_feed, polymorphic: true
  validates :news_feed_id, presence: true

  validates :name, presence: true, length: { maximum: 255 }

  validate :user_permission

  default_scope { order(created_at: :desc) }

  private
    def user_permission
      unless self.news_feed.can_post_news?(self.user)
        errors.add(:user, "does not have permission to post in this feed")
      end
    end
end
