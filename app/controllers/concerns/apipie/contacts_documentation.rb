module Apipie::ContactsDocumentation
  extend ActiveSupport::Concern
  included do
    def_param_group :contact_id do
      param :id, String, desc: 'Contact ID', required: true
    end

    def_param_group :contact do
      param :contact, Hash, required: true do
        param :name, String, desc: 'Contact name', required: true
        param :city, String, desc: 'Contact city', required: true
        param :state, String, desc: 'Contact state', required: true
        param :country, String, desc: 'Contact country', required: true
        param :street_address, String, desc: 'Contact street address', required: true
        param :secondary_address, String, desc: 'Contact secondary address', required: false
        param :building_number, String, desc: 'Contact building number', required: true
        param :zip_code, String, desc: 'Contact zip code', required: true
      end
    end

    resource_description do
      short 'API to manage contacts from users\' organizations'
      formats ['json']
      error 401, 'Unauthorized'
      error 404, 'Organization not found'
      description <<-EOD
      === Authentication Required
       - Authentication token has to be passed as HTTP header(HTTP_AUTHORIZATION);
      EOD
      param :organization_id, String, desc: 'Organization ID', required: true
    end

    api :GET, 'organizations/:organization_id/contacts', 'List all contacts from organization'
    def index; end

    api :GET, 'organizations/:organization_id/contacts/:id', 'Show contact'
    param_group :contact_id
    error 404, 'Contact not found'
    def show; end

    api :POST, 'organizations/:organization_id/contacts', 'Create contact'
    param_group :contact
    error 422, 'Contact not created'
    def create; end

    api :PUT, 'organizations/:organization_id/contacts/:id', 'Update contact'
    param_group :contact_id
    param_group :contact
    error 404, 'Contact not found'
    error 422, 'Contact not updated'
    def update; end

    api :DELETE, 'organizations/:organization_id/contacts/:id', 'Destroy contact'
    param_group :contact_id
    error 404, 'Contact not found'
    error 422, 'Contact not destroyed'
    def destroy; end
  end
end
