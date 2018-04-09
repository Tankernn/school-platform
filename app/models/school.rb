class School < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }

  has_many :administrations, dependent: :destroy
  has_many :administrators, through: :administrations,
                            class_name: "User", source: :user

  has_many :courses

  has_many :users

  has_many :data_files, as: :repository

  def can_download_files?(user)
    self.users.include?(user) || self.administrators.include?(user)
  end

  def can_upload_files?(user)
    self.administrators.include?(user)
  end

  has_many :news_posts, as: :news_feed

  def can_post_news?(user)
    self.administrators.include?(user)
  end
end
