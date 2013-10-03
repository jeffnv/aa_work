class Tagging < ActiveRecord::Base
  attr_accessible :url_id, :tag_topic_id

  def self.tag!(tag_topic, shortened_url)
    self.create!({tag_topic_id: tag_topic.id, url_id: shortened_url.id})
  end

  belongs_to(
    :url,
    class_name: 'ShortenedUrl',
    foreign_key: :url_id,
    primary_key: :id
  )

  belongs_to(
    :tag_topic,
    class_name: 'TagTopic',
    foreign_key: :tag_topic_id,
    primary_key: :id
  )

  validates :url_id, :uniqueness => {:scope => :tag_topic_id}


end
