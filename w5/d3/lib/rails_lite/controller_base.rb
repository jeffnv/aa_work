require 'erb'
require_relative 'params'
require_relative 'session'
require 'active_support/core_ext'

class ControllerBase
  attr_reader :params

  def initialize(req, res, route_params)
    p route_params
    @request = req
    @response = res
    @params = Params.new(req, route_params)
    @already_built_response = false
  end

  def session
    @session ||= Session.new(@request)
  end

  def already_rendered?
    
  end

  def redirect_to(url)
    unless @already_built_response
      @response.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, url)
      @already_built_response = true
      session.store_session(@response)
    end
    
  end

  def render_content(content, type)
    unless @already_built_response
      @response.content_type = type
      @response.body = content
      @already_built_response = true
      session.store_session(@response)
    end
  end

  def render(template_name)
    unless @already_built_response
      path = "views/#{self.class.name.underscore}/#{template_name}.html.erb"
      content = File.read(path)
      output = ERB.new(content).result(binding)
      type = 'text/text'
      render_content(output, type)
    end
  end

  def invoke_action(name)
    self.send(name)
    unless @already_built_response
      render(name)
    end
      
  end

end
