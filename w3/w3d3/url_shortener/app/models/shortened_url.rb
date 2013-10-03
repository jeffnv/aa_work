class ShortenedUrl < ActiveRecord::Base

  attr_accessible :long_url, :short_url, :submitter_id

  validates :long_url, { presence: true, uniqueness: true }
  validates :short_url, { presence: true }
  validates :submitter_id, { presence: true }

  belongs_to(
    :submitter,
    :class_name => 'User',
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name  => 'Visit',
    :foreign_key => :visited_url_id,
    :primary_key => :id
  )

  has_many(
    :visitors,
    :through => :visits,
    :uniq => true
  )

  has_many(
    :taggings,
    :class_name => 'Tagging',
    :foreign_key => :url_id,
    :primary_key => :id
  )

  has_many(
    :tag_topics,
    :through => :taggings
  )

  def self.random_code
    while true do
      unique_code = SecureRandom.urlsafe_base64(3)
      return unique_code if self.where("short_url LIKE '%#{unique_code}'").empty?
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    self.create!({long_url: long_url,
                  short_url: random_code,
                  submitter_id: user.id})
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques(minutes_ago = 10)
    visitors.where("visits.created_at >'#{ minutes_ago.minutes.ago }'").count
  end


end
