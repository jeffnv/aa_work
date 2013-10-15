class Note < ActiveRecord::Base
  attr_accessible :body, :track_id, :user_id
  validates :body, :track_id, :user_id, presence: true
  
  belongs_to :user
  belongs_to :track
end
