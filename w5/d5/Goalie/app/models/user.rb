class User < ActiveRecord::Base
  attr_reader :password
  attr_accessible :username, :password
  validates_presence_of :username, :password_digest, :session_token
  validates_uniqueness_of :username
  validates :password, length: {minimum: 6}, on: :create
  validates :username, length: {minimum: 1}
  before_validation :ensure_session_token
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
  
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end
  
  def password=(pword)
    @password = pword
    self.password_digest = BCrypt::Password.create(pword)
  end
  
  def self.find_by_credentials(creds)
    user =User.find_by_username(creds[:username])
    if user
      return user if user.is_password?(creds[:password])
    end
    nil
  end
  def is_password?(pword)
    BCrypt::Password.new(self.password_digest).is_password?(pword)
  end
end
