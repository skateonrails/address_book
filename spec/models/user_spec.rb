require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryGirl.build(:user) }

  it { should have_and_belong_to_many(:organizations) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_value('example@domain.com').for(:email) }
  it { should validate_length_of(:password).is_at_least(5) }
  it { should be_valid }
end
