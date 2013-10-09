class ContactSharesController < ApplicationController
  def destroy
    cs = ContactShare.find_by_id(params[:id])
    if cs
      render :json => cs.destroy
    else
      render :text => "contact share not found"
    end
  end

  def create
    cs = ContactShare.new(params[:contact_share])
    if cs.save
      render :json => cs
    else
      render :json => cs.errors, :status => :unprocessable_entity
    end
  end
end
