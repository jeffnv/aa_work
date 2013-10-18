class LinkSub < ActiveRecord::Base
  attr_accessible :link_id, :sub_id

  validates :link_id, :sub_id, :presence => true

  belongs_to :sub

  belongs_to :link

end
