require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject { build(:contact) }
  let(:created_contact) { build(:contact_with_id) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:building_number) }
  it { should validate_numericality_of(:building_number).only_integer }
  it { should validate_presence_of(:zip_code) }
  it { should respond_to(:secondary_address) }

  it { should be_valid }
  it { expect(subject.persisted?).to be false }
  it { expect(created_contact.persisted?).to be true }

  it { expect(subject.model_name.name.downcase).to eq('contact') }

  it { should respond_to(:serializable_hash) }
  it { expect(subject.serializable_hash[:name]).to eq(subject.name) }

  it { should respond_to(:as_json) }
end
