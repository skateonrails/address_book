class ContactsController < ApplicationController
  def index
    render json: contacts
  end

  def show
    render json: contact
  end

  def create
    command = Firebase::SetContact.call(organization, contact_params)
    if command.success?
      contact = command.result
      render json: contact, status: :created, location: [organization, contact]
    else
      render json: command.errors, status: :unprocessable_entity
    end
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

  def contact_params
    params.require(:contact).permit(:name, :city, :state, :country,
                                    :street_address, :secondary_address,
                                    :building_number, :zip_code)
  end

end
