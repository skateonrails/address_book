require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:organization) { create(:organization_for_vcr) }

  let(:valid_attributes) {
    { contact: attributes_for(:contact), organization_id: organization.id }
  }

  let(:invalid_attributes) {
    { contact: {name: '', city: '', state: '', country: '', street_address: '', building_number: '', zip_code: ''},
      organization_id: organization.id }
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

  describe "GET #update" do
    it "returns http success" do
      put :update, params: {organization_id: organization.id, id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      delete :destroy, params: {organization_id: organization.id, id: 1}
      expect(response).to have_http_status(:success)
    end
  end

end
