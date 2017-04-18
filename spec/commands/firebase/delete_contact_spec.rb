require 'rails_helper'

RSpec.describe 'Firebase::DeleteContact', :vcr do
  subject { Firebase::DeleteContact }
  let(:organization) { create(:organization_for_vcr) }
  let(:contact_id) { attributes_for(:contact_with_id)[:id] }
  let(:contact) { Firebase::GetContact.call(organization, contact_id).result }
  let(:command) { subject.call(organization, contact.id) }

  context 'with valid id' do
    it 'should delete contact' do
      expect(command.success?).to be true
      expect(command.result).to be true
    end
  end
end
