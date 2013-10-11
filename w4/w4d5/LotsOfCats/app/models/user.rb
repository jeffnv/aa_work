require 'bcrypt'
class User < ActiveRecord::Base
  attr_accessible :password, :user_name
  attr_reader :password
  validates :password, length: { minimum: 2 }, on: :create
  validates :user_name, :session_token, :password_digest, :presence => true
  after_initialize :set_session_token

  has_many :cats

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(user_name, password)
    u = self.find_by_user_name(user_name)
    if !!u
      return u if u.is_password?(password)
    end
    return nil
  end

  def password=(password)
    @password = password
    password_hash = BCrypt::Password.create(password)
    self.password_digest = password_hash
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def set_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def reset_session_token!
    @session_token = self.class.generate_session_token
    self.save!
  end
end
