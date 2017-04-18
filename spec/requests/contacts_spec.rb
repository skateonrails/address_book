require 'rails_helper'


RSpec.describe 'Contacts', type: :request do
  let(:organization) { create(:organization_for_vcr) }
  let(:contact_id) { attributes_for(:contact_with_id)[:id] }

  describe "GET /organizations/:organization_id/contacts" do
    before :each do
      VCR.use_cassette("Firebase_GetContacts/with_valid_organization/should_get_contacts_from_organization", match_requests_on: [:method, :host]) do
        get organization_contacts_path(organization)
      end
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns contacts objects" do
      expect(struct_response.count).to eq(1)
      expect(struct_response.first.name).to eq('Contact Name')
    end
  end

  describe "GET /organizations/:organization_id/contacts/:id" do
    before :each do
      VCR.use_cassette("Firebase_GetContact/with_valid_organization/should_get_contacts_from_organization", match_requests_on: [:method, :host]) do
        get organization_contact_path(organization, contact_id)
      end
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns contact object" do
      expect(struct_response.name).to eq('Contact Name')
    end
  end

  describe 'POST /organizations/:organization_id/contacts' do
    context 'when the request is valid' do
      let(:attributes) { attributes_for(:contact) }

      before :each do
        VCR.use_cassette("Firebase_SetContact/with_valid_params/should_create_contact") do
          post organization_contacts_path(organization), params: { contact: attributes }
        end
      end

      it { expect(response).to have_http_status(201) }

      it 'creates a contact' do
        expect(struct_response.name).to eq(attributes[:name])
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { {name: '', city: '', state: '',
                                  country: '', street_address: '',
                                  building_number: '', zip_code: ''} }

      before :each do
        post organization_contacts_path(organization), params: { contact: invalid_attributes }
      end

      it { expect(response).to have_http_status(422) }

      it 'returns a validation failure message' do
        expect(struct_response.error['name'].first).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /organizations/:organization_id/contacts/:id' do
    context 'when the request is valid' do
      let(:attributes) { attributes_for(:contact) }

      before :each do
        VCR.use_cassette("Firebase_UpdateContact/with_valid_params/should_update_contact") do
          put organization_contact_path(organization, contact_id), params: { contact: attributes }
        end
      end

      it { expect(response).to have_http_status(:success) }

      it 'updates a contact' do
        expect(struct_response.name).to eq(attributes[:name])
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { {name: '', city: '', state: '',
                                  country: '', street_address: '',
                                  building_number: '', zip_code: ''} }

      before :each do
        VCR.use_cassette("Firebase_UpdateContact/with_invalid_params/should_not_update_contact") do
          put organization_contact_path(organization, contact_id), params: { contact: invalid_attributes }
        end
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it 'returns a validation failure message' do
        expect(struct_response.error['name'].first).to match(/can't be blank/)
      end
    end
  end

  describe 'DELETE /organizations/:organization_id/contacts/:id' do
    context 'when the request is valid' do
      before :each do
        VCR.use_cassette("Firebase_DeleteContact/with_valid_id/should_delete_contact") do
          delete organization_contact_path(organization, contact_id)
        end
      end

      it { expect(response).to have_http_status(204) }
    end
  end
end
