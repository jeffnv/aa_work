class Visit < ActiveRecord::Base
  attr_accessible :visitor_id, :visited_url_id
  belongs_to(
    :visitor,
    :class_name => 'User',
    :foreign_key => :visitor_id,
    :primary_key => :id
  )

  belongs_to(
    :visited_url,
    :class_name => 'ShortenedUrl',
    :foreign_key => :visited_url_id,
    :primary_key => :id
  )

  def self.record_visit!(user, shortened_url)
    self.create!({visitor_id: user.id, visited_url_id: shortened_url.id})
  end
end
