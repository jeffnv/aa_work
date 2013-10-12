class Session < ActiveRecord::Base
  attr_accessible :env, :session_token, :user_id
  validates :session_token, :user_id,  presence: true
  belongs_to :user

  def self.find_user_by_session_token(token)
    session = self.find_by_session_token(token)
    if !!session
      User.find_by_id(session.user_id)
    else
    end
  end
end
