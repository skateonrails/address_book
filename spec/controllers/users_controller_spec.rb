require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:now) { Time.local(2017, 4, 18, 15, 0, 0) }
  let(:user) { create(:user) }
  let(:valid_token) { AuthenticateUser.call(attributes).result }
  let(:valid_session) { {} }

  before :each do
    Timecop.freeze(now)
  end

  describe "POST #login" do
    before :each do
      post :login, params: attributes
    end

    context 'with valid email and password' do
      let(:attributes) {
        { email: user.email, password: user.password }
      }

      it { expect(response).to have_http_status(:success) }

      it 'should return auth_token' do
        expect(struct_response.auth_token).to eq( valid_token )
      end
    end

    context 'with invalid email' do
      let(:attributes) {
        { email: Faker::Internet.email, password: 'invalid_password' }
      }

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(struct_response.error).to be_present }
    end

    context 'with invalid password' do
      let(:attributes) {
        { email: user.email, password: 'invalid_password' }
      }

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(response.body).to match(/invalid credentials/) }
    end
  end

  describe "POST #create" do
    before :each do
      post :create, params: attributes
    end

    context 'with valid email and password' do
      let(:attributes) {
        { user: { email: Faker::Internet.email, password: 'new_user_passW0rd' } }
      }

      it { expect(response).to have_http_status(:created) }

      it 'should return user' do
        expect(struct_response.email).to eq( attributes[:user][:email] )
      end
    end

    context 'with valid email and password and organization association' do
      let(:organization) { create(:organization) }
      let(:attributes) {
        { user: { email: Faker::Internet.email, password: 'new_user_passW0rd', organization_ids: [organization.id] } }
      }

      it { expect(response).to have_http_status(:created) }

      it 'should return user' do
        expect(struct_response.email).to eq( attributes[:user][:email] )
      end

      it 'should associate user with organizations' do
        created_user = User.find struct_response.id
        expect(created_user.organization_ids).to eq(attributes[:user][:organization_ids])
      end
    end

    context 'with invalid email' do
      let(:attributes) {
        { user: { email: 'ivalid_email', password: 'new_user_passW0rd' } }
      }

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end
