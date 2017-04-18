require 'rails_helper'

RSpec.describe AuthorizeUser do
  let(:user) { create(:user) }
  subject { AuthorizeUser }
  let(:command) { subject.call(authentication_token) }

  context 'when token is valid' do
    let(:authentication_token) { AuthenticateUser.call(email: user.email, password: user.password).result }

    context 'when user is found' do
      it { expect(command.success?).to be true }

      it { expect(command.result).to eq(user) }
    end

    context 'when user is not found' do
      before :each do
        authentication_token
        User.destroy_all
      end

      it 'should raise NotFound error' do
        expect{ command.result }.to raise_error( ActiveRecord::RecordNotFound )
      end
    end
  end
end
