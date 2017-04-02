require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  subject { AuthenticateUser }

  context 'when user is found' do
    let(:command) { subject.call(email: user.email, password: user.password) }

    it { expect(command.success?).to be true }

    it { expect(command.result).not_to be_empty }
  end

  context 'when user is not found' do
    let(:command) { subject.call(email: 'non_existing@email.com', password: 'none') }

    it { expect(command.success?).to be false }

    it { expect(command.result).to be_nil }
  end
end
