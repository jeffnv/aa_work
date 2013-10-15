require 'bcrypt'
class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :session_token, 
                  :password, :activated, :activation_token
  
  attr_reader :password
  
  validates :password_digest, :session_token, :email, presence: true
  validates :password, :length => {minimum: 6}, on: :create
  validates :email, uniqueness: true
  
  has_many :notes

  before_validation :ensure_session_token
  after_initialize :ensure_activated
    
  def password=(pword)
    @password = pword
    self.password_digest = BCrypt::Password.create(pword)
  end
  
  def is_password?(pword)
    BCrypt::Password.new(self.password_digest).is_password?(pword)
  end
  
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
  
  def self.find_by_credentials(creds)
    user = User.find_by_email(creds[:email])
    if !!user
      return user if user.is_password?(creds[:password])
    end
    nil
    
  end
  
  def ensure_activated
    self.activated ||= false
  end
  
  def activate!
    self.activated = true
    self.save!
  end
  
  def create_activation_token!
    self.activation_token = User.generate_session_token
    self.save
    self.activation_token
  end
  
end
