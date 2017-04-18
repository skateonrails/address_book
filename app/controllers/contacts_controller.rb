class ContactsController < TokenAuthenticatableController
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
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  def update
    command = Firebase::UpdateContact.call(organization, contact.id, contact_params)
    if command.success?
      contact = command.result
      render json: contact
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    command = Firebase::DeleteContact.call(organization, contact.id)
    if command.success?
      render status: :no_content
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  private

  def organization
    @organization ||= current_user.organizations.find(params[:organization_id])
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
