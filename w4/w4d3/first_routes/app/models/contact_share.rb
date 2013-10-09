class ContactShare < ActiveRecord::Base
  attr_accessible :contact_id, :user_id

  belongs_to :user, :class_name => "User",
    :primary_key => :id, :foreign_key => :user_id
  belongs_to :contact, :class_name => "Contact",
    :primary_key => :id, :foreign_key => :contact_id

  validates :contact_id, :user_id, :presence => true
end
