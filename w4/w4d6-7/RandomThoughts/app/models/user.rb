class User < ActiveRecord::Base
  attr_reader :password
  attr_accessible :email, :password
  validates :email, :session_token, presence: true
  validates :password_digest, presence: { :message => "Password can't be blank" }
  validates :password, :length => { :minimum => 2}, :allow_nil => true 
  validates :email, uniqueness: true
  
  before_validation :ensure_session
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def ensure_session
    self.session_token ||= generate_new_token
  end
  
  def self.find_by_credentials(params)
    user = User.find_by_email(params[:email])
    if !!user
      return user if user.is_password?(params[:password])
    end
    nil
  end
  
  def generate_new_token
    SecureRandom.urlsafe_base64(16)
  end
  def reset_session_token
    self.session_token = generate_new_token
    self.save!
    self.session_token
  end
  
  
end
