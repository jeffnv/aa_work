class Photo < ActiveRecord::Base
  attr_accessible  :title, :url #to prevent assigning lots of photos bad
  validates :owner_id, :title, :url, presence: true
  validates :url, uniqueness: true

  belongs_to :owner, {
    :class_name => "User",
    :foreign_key => :owner_id
  }
  has_many :photo_taggings, {
    :class_name => "PhotoTagging",
    :foreign_key => :photo_id,
    :primary_key => :id
  }
  has_many :tagged_users, :through => :photo_taggings, :source => :user
end
