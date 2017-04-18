require 'rails_helper'

RSpec.describe 'Organizations', type: :request do
  let(:current_user) { create(:admin_user) }
  let(:organization) { create(:organization) }
  let(:attributes) { { name: Faker::Company.name } }
  let(:not_found_params) { { id: Organization.count + 100 } }

  describe 'GET /organizations' do
    before :each do
      organization
      get organizations_path, headers: login_user_headers(current_user)
    end

    it { expect(response).to have_http_status(200) }

    it 'should return organizations' do
      expect(struct_response.count).to eq(1)
      expect(struct_response.first.name).to eq(organization.name)
    end
  end

  describe 'GET /organizations/:id' do
    context 'when record exists' do
      before :each do
        get organization_path(organization), headers: login_user_headers(current_user)
      end

      it { expect(response).to have_http_status(200) }

      it 'should return organization' do
        expect(struct_response.name).to eq(organization.name)
      end
    end

    context 'when record does not exists' do
      before :each do
        get organization_path(not_found_params), headers: login_user_headers(current_user)
      end

      it { expect(response).to have_http_status(404) }

      it 'returns a not found message' do
        expect(struct_response.error['message']).to match(/Couldn't find/)
      end
    end
  end

  describe 'POST /organizations' do
    context 'when the request is valid' do
      before :each do
        post organizations_path, params: { organization: attributes }, headers: login_user_headers(current_user)
      end

      it { expect(response).to have_http_status(201) }

      it 'creates a organization' do
        expect(struct_response.name).to eq(attributes[:name])
      end
    end

    context 'when the request is invalid' do
      let(:attributes) { { name: '' } }

      before :each do
        post organizations_path, params: { organization: attributes }, headers: login_user_headers(current_user)
      end

      it { expect(response).to have_http_status(422) }

      it 'returns a validation failure message' do
        expect(struct_response.error['message']).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /organizations/:id' do
    context 'when record exists' do
      before :each do
        put organization_path(organization, params: { organization: attributes } ), headers: login_user_headers(current_user)
      end

      it { expect(response).to have_http_status(200) }

      it 'should return organization' do
        expect(struct_response.name).to eq(attributes[:name])
      end
    end

    context 'when record does not exists' do
      before :each do
        get organization_path(not_found_params), headers: login_user_headers(current_user)
      end

      it { expect(response).to have_http_status(404) }

      it 'returns a not found message' do
        expect(struct_response.error['message']).to match(/Couldn't find/)
      end
    end

    context 'when parameters are invalid' do
      let(:attributes) { { name: '' } }

      before :each do
        put organization_path(organization, params: { organization: attributes } ), headers: login_user_headers(current_user)
      end

      it { expect(response).to have_http_status(422) }

      it 'returns a not found message' do
        expect(struct_response.error['message']).to match(/can't be blank/)
      end
    end
  end

  describe 'DELETE /organizations/:id' do
    context 'when record exists' do
      before :each do
        delete organization_path(organization), headers: login_user_headers(current_user)
      end

      it { expect(response).to have_http_status(204) }
    end

    context 'when record not exists' do
      before :each do
        delete organization_path(not_found_params), headers: login_user_headers(current_user)
      end

      it { expect(response).to have_http_status(404) }
    end
  end
end
