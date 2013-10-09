class Status < ActiveRecord::Base
  attr_accessible :body, :twitter_status_id, :twitter_user_id
  validates :body, :twitter_status_id, :twitter_user_id, :presence => true
  validates :twitter_status_id, uniqueness: true

  belongs_to :author,
             :class_name => "User",
             :foreign_key => :twitter_user_id,
             :primary_key => :twitter_user_id

  def self.fetch_statuses_for_user(user)
    uri = Addressable::URI.new(
    :scheme => "https",
    :host => "api.twitter.com",
    :path => "/1.1/statuses/user_timeline.json",
    :query_values => {:user_id => user.twitter_user_id}
    ).to_s

    self.parse_twitter_params(TwitterSession.get(uri))
  end

  def self.parse_twitter_params(status_data)
    status_data.each do |datum|
      init_data = datum.select{|k, v| k== 'id' || k == 'text' || k = 'user'}
      init = {body: init_data['text'], twitter_status_id: init_data['id'], twitter_user_id: init_data['user']['id']}
      Status.create(init)
    end
    nil
  end
end
