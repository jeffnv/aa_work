class Gist < ActiveRecord::Base
  attr_accessible :title, :user_id, :gist_files_attributes, :tags_attributes
  belongs_to :user
  has_many :favorites
  has_many :gist_files
  has_many :taggings
  has_many :tags, through: :taggings, source: :tag
  accepts_nested_attributes_for :gist_files, :tags
end
