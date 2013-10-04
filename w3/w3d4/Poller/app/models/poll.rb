class Poll < ActiveRecord::Base
  attr_accessible :title, :author_id
  validates :title, presence: true
  validates :author_id, presence: true

  belongs_to(
  :user,
  class_name: 'User',
  foreign_key: :author_id,
  primary_key: :id
  )

  has_many(
  :questions,
  class_name: 'Question',
  foreign_key: :poll_id,
  primary_key: :id
  )




end
