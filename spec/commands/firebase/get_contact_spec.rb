require 'rails_helper'

RSpec.describe 'Firebase::GetContact', :vcr do
  subject { Firebase::GetContact }
  let(:organization) { create(:organization_for_vcr) }
  let(:contact_id) { '-Kh-cQRNupsqgLBbRdJX' }
  let(:command) { subject.call(organization, contact_id) }

  context 'with valid organization' do
    it 'should get contacts from organization' do
      expect(command.success?).to be true
      expect(command.result).is_a?(Contact)
    end
  end

  context 'with invalid organization' do
    let(:organization) { double('invalid_organization')}

    it 'should return a blank result' do
      allow(organization).to receive(:id).and_return(1)
      expect(command.success?).to be true
      expect(command.result).to be_nil
    end
  end

  context 'with invalid id' do
    let(:contact_id) { 'invalid_id' }

    it 'should return a blank result' do
      expect(command.success?).to be true
      expect(command.result).to be_nil
    end
  end
end
