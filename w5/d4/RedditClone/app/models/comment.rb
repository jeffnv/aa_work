class Comment < ActiveRecord::Base
  attr_accessible :body, :link_id, :parent_comment_id, :author_id
  validates :body, :link_id, :author_id, presence: true

  belongs_to :parent_comment, class_name: 'Comment'
  has_many :child_comments, foreign_key: :parent_comment_id, class_name: 'Comment'
  belongs_to :link
  belongs_to :author, class_name: 'User', foreign_key: :author_id
end
