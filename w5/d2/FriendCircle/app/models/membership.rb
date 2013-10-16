class Membership < ActiveRecord::Base
  attr_accessible :circle_id, :user_id
  belongs_to :circle
  belongs_to :user
end
