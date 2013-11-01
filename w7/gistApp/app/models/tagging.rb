class Tagging < ActiveRecord::Base
  attr_accessible :gist_id, :tag_id
  belongs_to :gist
  belongs_to :tag
end
