class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern = pattern
    @http_method = http_method
    @controller_class = controller_class
    @action_name = action_name
  end

  def matches?(req)
    method_matches = req.request_method.downcase.to_sym == @http_method
    pattern_match = !!(req.path =~ @pattern)
    method_matches ==  pattern_match
  end

  def run(req, res)
    url_params = Route.extract_url_params(@pattern, req.path)
    @controller_class.new(req, res, url_params).invoke_action(action_name)
  end
  
  def self.extract_url_params(pattern, path)
    reg = Regexp.new(pattern) 
    matches = reg.match(path)
    {}.tap do |url_params|
      matches.names.each_with_index do |key, index|
        value = matches.captures[index]
        url_params[key.to_sym] = value
      end
    end
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  def add_route(pattern, method, controller_class, action_name)
    @routes << Route.new(pattern, method, controller_class, action_name)
  end

  def draw(&proc)    
    instance_eval(&proc)
  end

  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, klazz, action_name|
      add_route(pattern, http_method, klazz, action_name)
    end
  end

  def match(req)
    @routes.find{|route|route.matches?(req)}
  end

  def run(req, res)
    matched_route = match(req)
    if matched_route
      matched_route.run(req,res)
    else
      res.status(WEBrick::HTTPStatus::TemporaryRedirect)
    end
  end
end
