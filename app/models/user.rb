class User < ApplicationRecord
  attr_accessor :remember_token

  validates :name, presence: true, length: { maximum: 255 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  before_save { email.downcase! }

  validates :login, presence: true, length: { maximum: 50 },
                    format: { with: /\A[a-zA-Z0-9_]+\Z/ },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 },
                       if: lambda { new_record? || !password.blank? ||
                                    !password_confirmation.blank? }

  enum gender: [ :unspecified, :male, :female, :other ]

  VALID_PHONE_REGEX = /[0-9a-z\-+() .]*/i
  validates :phone, length: { maximum: 255 },
                    format: { with: VALID_PHONE_REGEX }

  validates :birth_date, presence: true

  mount_uploader :picture, PictureUploader
  validate :picture_size

  has_many :messages
  has_many :conversation_participations, dependent: :destroy
  has_many :conversations, through: :conversation_participations

  has_many :administrations, dependent: :destroy
  has_many :schools_administering, through: :administrations,
                                   class_name: "School", source: :school

  belongs_to :school, optional: true

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  def is_administrator_at?(school)
    school ? school.administrators.include?(self) : false
  end

  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
