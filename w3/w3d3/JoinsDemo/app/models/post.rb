class Post < ActiveRecord::Base
  [ :title,
    :body,
    :author_id ].each do |field|
    attr_accessible field
    validates field, :presence => true
  end

  belongs_to :author, :class_name => "User"
  has_many :comments, :foreign_key => :post_id
end
