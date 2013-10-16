require 'bcrypt'
class User < ActiveRecord::Base
  attr_reader :password
  attr_accessible :email, :password
  validates :email, :password_digest, :session_token, presence: true
  before_validation :ensure_token

  has_many :friendships, foreign_key: :friender_id

  has_many :circles, foreign_key: :owner_id

  has_many :friends, through: :friendships, source: :friendee

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def password=(pword)
    self.password_digest = BCrypt::Password.create(pword)
  end

  def password_is?(pword)
    BCrypt::Password.new(self.password_digest).is_password?(pword)
  end

  def ensure_token
    self.session_token ||= User.generate_session_token
  end

  def self.find_by_credentials(credentials)
    user = User.find_by_email(credentials[:email])
    if !!user
      return user if user.password_is?(credentials[:password])
    end
    nil
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def generate_reset_token!
    self.reset_token = User.generate_session_token
    self.save!
    self.reset_token
  end


end
