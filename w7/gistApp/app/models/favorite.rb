class Favorite < ActiveRecord::Base
  attr_accessible :gist_id, :user_id
  belongs_to :user
  belongs_to :gist

  validates :user_id, uniqueness: {scope: :gist_id}
end
