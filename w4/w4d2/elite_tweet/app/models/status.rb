class Status < ActiveRecord::Base
  attr_accessible :body, :twitter_status_id, :twitter_user_id
  validates :body, :twitter_status_id, :twitter_user_id, :presence => true
end
