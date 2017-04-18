require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:organization) { create(:organization_for_vcr) }

  let(:valid_attributes) {
    { contact: attributes_for(:contact), organization_id: organization.id }
  }

  let(:valid_update_attributes) {
    { id: attributes_for(:contact_with_id)[:id], contact: attributes_for(:contact), organization_id: organization.id }
  }

  let(:valid_destroy_attributes) {
    { id: attributes_for(:contact_with_id)[:id], organization_id: organization.id }
  }

  let(:invalid_attributes) {
    {
      organization_id: organization.id,
      contact: {name: '', city: '', state: '', country: '', street_address: '', building_number: '', zip_code: ''}
    }
  }

  let(:invalid_update_attributes) {
    {
      id: attributes_for(:contact_with_id)[:id],
      organization_id: organization.id,
      contact: {name: '', city: '', state: '', country: '', street_address: '', building_number: '', zip_code: ''}
    }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns http success" do
      VCR.use_cassette("Firebase_GetContacts/with_valid_organization/should_get_contacts_from_organization") do
        get :index, params: {organization_id: organization.id}
        expect(response).to have_http_status(:success)
        expect(struct_response.count).to eq(1)
      end
    end
  end

  describe "GET #show" do
    it "returns http success" do
      VCR.use_cassette("Firebase_GetContact/with_valid_organization/should_get_contacts_from_organization") do
        get :show, params: {organization_id: organization.id, id: '-Kh-cQRNupsqgLBbRdJX' }
        expect(response).to have_http_status(:success)
        expect(struct_response.name).to eq('Contact Name')
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'renders a JSON response with the new contact' do
        VCR.use_cassette("Firebase_SetContact/with_valid_params/should_create_contact") do
          post :create, params: valid_attributes, session: valid_session
          expect(response).to have_http_status(:created)
          expect(response.content_type).to eq('application/json')
          expect(response.location).to eq( organization_contact_url(organization, '-KhEQk5ZrCXPgs0fctiQ') )
        end
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new organization' do
        post :create, params: invalid_attributes, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context 'with valid params' do
      it 'updates the requested contact' do
        VCR.use_cassette("Firebase_UpdateContact/with_valid_params/should_update_contact") do
          put :update, params: valid_update_attributes, session: valid_session
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq('application/json')
          expect(response.body).to match(valid_update_attributes[:contact].to_json)
        end
      end
    end

    context 'with invalid params' do
      it 'does not updates the requested contact' do
        VCR.use_cassette("Firebase_UpdateContact/with_invalid_params/should_not_update_contact") do
          put :update, params: invalid_update_attributes, session: valid_session
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json')
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context 'with valid id' do
      it 'deletes the requested contact' do
        VCR.use_cassette("Firebase_DeleteContact/with_valid_id/should_delete_contact") do
          delete :destroy, params: valid_destroy_attributes, session: valid_session
          expect(response).to have_http_status(:no_content)
          expect(Firebase::GetContact.call(organization, valid_destroy_attributes[:id]).result).to be nil
        end
      end
    end
  end
end
