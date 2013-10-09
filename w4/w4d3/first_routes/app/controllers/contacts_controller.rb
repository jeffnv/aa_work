class ContactsController < ApplicationController
  def index
    render :json => Contact.all
  end
end
