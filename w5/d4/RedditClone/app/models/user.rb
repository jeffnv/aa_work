class User < ActiveRecord::Base
  attr_reader :password
  attr_accessible :password, :username
  validates :password, presence: true, on: :create
  validates :password, length: {minimum: 6}, on: :create
  validates :username, :presence => true, :uniqueness => true
  validates :session_token, :password_digest, :presence => true

  before_validation :ensure_session_token

  has_many :subs, :foreign_key => :moderator_id
  has_many :submitted_links, foreign_key: :submitter_id, class_name: 'Link'
  has_many :comments, foreign_key: :author_id, class_name: 'Comment'

  def password=(pass)
    @password = pass
    self.password_digest = BCrypt::Password.create(pass)
  end

  def is_password?(pass)
    BCrypt::Password.new(self.password_digest).is_password?(pass)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def self.find_by_credentials(credentials)
    user = User.find_by_username(credentials[:username])
    if user
      return user if user.is_password?(credentials[:password])
    end
    nil
  end
end

