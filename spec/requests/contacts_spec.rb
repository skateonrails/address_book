require 'rails_helper'


RSpec.describe 'Contacts', type: :request do
  let(:organization) { create(:organization_for_vcr) }

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
    let(:contact_id) { '-Kh-cQRNupsqgLBbRdJX' }

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
end
