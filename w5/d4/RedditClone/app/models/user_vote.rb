class UserVote < ActiveRecord::Base
  attr_accessible :link_id, :voter_id, :vote

  validates :link_id, :voter_id, :vote, :presence => true

  validates_uniqueness_of :voter_id, :scope => :link_id

  belongs_to :link

  belongs_to :voter, foreign_key: :voter_id, class_name: 'User'
end