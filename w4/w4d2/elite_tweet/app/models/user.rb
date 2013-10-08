class User < ActiveRecord::Base
  attr_accessible :twitter_user_id, :screen_name
  validates :twitter_user_id, :screen_name, :presence => true

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
    init_data = user_data.first.select{|k, v| k== 'id_str' || k == 'screen_name'}
    User.new({twitter_user_id: init_data['id_str'], screen_name: init_data['screen_name']})
  end

end
