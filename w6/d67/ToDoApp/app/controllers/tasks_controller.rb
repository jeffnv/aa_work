class TasksController < ApplicationController
  respond_to :json
  respond_to :html, :only => [:index]

  def create
    # ...
  end

  def index
    @tasks = Task.all
    respond_to do |format|
      format.html { render :index } # entry-point for Backbone app
      format.json { render :json => @tasks }
    end
  end
end