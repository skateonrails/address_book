class ContactsController < ApplicationController
  def index
    render json: contacts
  end

  def show
    render json: contact
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def organization
    @organization ||= Organization.find(params[:organization_id])
  end

  def contacts
    return @contacts if @contacts.present?
    command = Firebase::GetContacts.call(organization)
    @contacts = command.result
  end

  def contact
    return @contact if @contact.present?
    command = Firebase::GetContact.call(organization, params[:id])
    @contact = command.result
  end
end
