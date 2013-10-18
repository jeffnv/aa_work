class Sub < ActiveRecord::Base
  attr_accessible :moderator_id, :name

  validates :name, :moderator_id, :presence => true

  belongs_to :moderator, :foreign_key => :moderator_id, :class_name => 'User'

  has_many :links, :through => :link_subs, :source => :link
end
