require 'rails_helper'

RSpec.describe 'Firebase::UpdateContact', :vcr do
  subject { Firebase::UpdateContact }
  let(:organization) { create(:organization_for_vcr) }
  let(:params) { attributes_for(:contact) }
  let(:contact_id) { attributes_for(:contact_with_id)[:id] }

  let(:contact) { Firebase::GetContact.call(organization, contact_id).result }
  let(:command) { subject.call(organization, contact.id, params) }

  context 'with valid params' do
    it 'should update contact' do
      expect(command.success?).to be true
      expect(command.result).is_a?(Contact)
      expect(command.result.valid?).to be true
    end
  end

  context 'with invalid params' do
    let(:params) { {} }
    it 'should not update contact' do
      expect(command.success?).to be false
      expect(command.result).to be nil
    end
  end
end
