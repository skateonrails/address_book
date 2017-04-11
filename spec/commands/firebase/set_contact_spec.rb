require 'rails_helper'

RSpec.describe 'Firebase::SetContact', :vcr do
  subject { Firebase::SetContact }
  let(:organization) { create(:organization_for_vcr) }
  let(:params) { attributes_for(:contact).reject{|key, value| key.to_sym == :id} }
  let(:command) { subject.call(organization, params) }

  context 'with valid params' do
    it 'should create contact' do
      expect(command.success?).to be true
      expect(command.result).is_a?(Contact)
      expect(command.result.valid?).to be true
    end
  end

  context 'with invalid params' do
    let(:params) { {} }
    it 'should not create contact' do
      expect(command.success?).to be false
      expect(command.result).to be nil
    end
  end
end
