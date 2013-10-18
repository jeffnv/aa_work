class Link < ActiveRecord::Base
  attr_accessible :body, :submitter_id, :title, :url
  validates :submitter_id, :body, :title, :url, presence: true

  belongs_to :submitter, foreign_key: :submitter_id, class_name: 'User'

  has_many :link_subs

  has_many :subs, :through => :link_subs, :source => :sub
  has_many :comments
  has_many :votes, foreign_key: :link_id, class_name: 'UserVote'

  def upvotes
    self.votes.where( :vote => 1 ).count
  end

  def downvotes
    self.votes.where( :vote => -1 ).count
  end
end
