require 'rails_helper'

RSpec.describe Organization, type: :model do
  subject { FactoryGirl.build(:organization) }

  it { should have_and_belong_to_many(:users) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
