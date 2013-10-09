class ContactsController < ApplicationController
  def index
    #render :json => Contact.all
    render :json => contacts_for_user_id(params[:user_id])
  end

  def contacts_for_user_id(user_id)
    c = Contact.joins(<<-SQL)
    LEFT JOIN contact_shares cs ON cs.contact_id = contacts.id
    SQL
    c.where("contacts.user_id = ? OR cs.user_id = ?" , user_id, user_id)
  end

  def create
    contact = Contact.new(params[:contact])
    if contact.save
      render :json => contact
    else
      render :json => contact.errors, :status => :unprocessable_entity
    end
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update_attributes(params[:contact])
      render :json => contact
    else
      render :json => contact.errors, :status => :unprocessable_entity
    end
  end

  def show
    contact = Contact.find_by_id(params[:id])
    if contact
      render :json => contact
    else
      render :text => "contact not found"
    end
  end

  def destroy
    contact = Contact.find_by_id(params[:id])
    if contact
      render :json => contact.destroy
    else
      render :text => "contact not found"
    end
  end
end
