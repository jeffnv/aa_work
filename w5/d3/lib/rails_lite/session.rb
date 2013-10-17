require 'json'
require 'webrick'

class Session
  COOKIE_NAME = '_rails_lite_app'
  def initialize(req, route_params = nil)
    #if req.cookies
      my_cookie = req.cookies.find{|cookie|cookie.name == COOKIE_NAME}
      if(my_cookie)
        @session_hash = JSON.parse(my_cookie.value)
      end
    # end
    
    @session_hash ||= {}
  end

  def [](key)
    @session_hash[key]
  end

  def []=(key, val)
    @session_hash[key] = val
  end

  def store_session(res)
    res.cookies << WEBrick::Cookie.new(COOKIE_NAME, @session_hash.to_json)
  end
end
