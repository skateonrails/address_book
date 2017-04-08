require 'rails_helper'

RSpec.describe 'Firebase::GetContacts', :vcr do
  subject { Firebase::GetContacts }
  let(:organization) { create(:organization_for_vcr) }
  let(:command) { subject.call(organization) }

  context 'with valid organization' do
    it 'should get contacts from organization' do
      expect(command.success?).to be true
      expect(command.result.first).is_a?(Contact)
      expect(command.result.first.id).to eq('-Kh-cQRNupsqgLBbRdJX')
    end
  end

  context 'with invalid organization' do
    let(:organization) { double('invalid_organization')}

    it 'should return a blank result' do
      allow(organization).to receive(:id).and_return(1)
      expect(command.success?).to be true
      expect(command.result.count).to eq(0)
    end
  end
end
