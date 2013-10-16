class Circle < ActiveRecord::Base
  attr_accessible :name, :owner_id, :friend_ids
  has_many :memberships
  has_many :friends, through: :memberships, source: :user
  belongs_to :user, foreign_key: :owner_id
  validates :name, :presence => true
end
