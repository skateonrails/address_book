require 'rails_helper'


RSpec.describe 'Users', type: :request do
  let(:now) { Time.local(2017, 4, 18, 15, 0, 0) }
  let(:user) { create(:user) }
  let(:valid_token) { AuthenticateUser.call(attributes).result }

  before :each do
    Timecop.freeze(now)
  end

  describe 'POST /authentication/authenticate' do
    before :each do
      post login_users_path, params: attributes
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
      let(:attributes) { { email: Faker::Internet.email, password: 'invalid_password' } }

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(struct_response.error).to be_present }
    end

    context 'with invalid password' do
      let(:attributes) { { email: user.email, password: 'invalid_password' } }

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(response.body).to match(/invalid credentials/) }
    end
  end
end
