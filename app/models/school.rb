class School < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }

  has_many :administrations, dependent: :destroy
  has_many :administrators, through: :administrations,
                            class_name: "User", source: :user

  has_many :courses

  has_many :users
end
