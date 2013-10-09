class User < ActiveRecord::Base
  attr_accessible :twitter_user_id, :screen_name
  validates :twitter_user_id, :screen_name, :presence => true
  validates :twitter_user_id, uniqueness: true

  has_many :tweets,
           :class_name => "Status",
           :foreign_key => :twitter_user_id,
           :primary_key => :twitter_user_id

  has_many :inbound_follows,
           :class_name => "Follow",
           :foreign_key => :twitter_followee_id,
           :primary_key => :twitter_user_id

  has_many :outbound_follows,
           :class_name => "Follow",
           :foreign_key => :twitter_follower_id,
           :primary_key => :twitter_user_id

  has_many :followed_users, :through => :outbound_follows, :source => :followee
  has_many :followers, :through => :inbound_follows, :source => :follower


  def self.fetch_by_screen_name(screen_name)
    uri = Addressable::URI.new(
    :scheme => "https",
    :host => "api.twitter.com",
    :path => "/1.1/users/lookup.json",
    :query_values => {:screen_name => screen_name}
    ).to_s
    user_data = TwitterSession.get(uri)
    self.parse_twitter_params(user_data)
  end

  def self.parse_twitter_params(user_data)
    init_data = user_data.first.select{|k, v| k== 'id' || k == 'screen_name'}
    User.create({twitter_user_id: init_data['id'], screen_name: init_data['screen_name']})
  end

  def sync_statuses
    Status.fetch_statuses_for_user(self)
  end

end
