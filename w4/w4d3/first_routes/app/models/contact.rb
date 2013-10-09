class Contact < ActiveRecord::Base
  attr_accessible :email, :name, :user_id

  belongs_to :user, :class_name => "User",
             :primary_key => :id, :foreign_key => :user_id

  validates :email, :name, :user_id, :presence => true
end
