FactoryGirl.define do
  factory :organization do
    name { Faker::Company.name }

    factory :organization_for_vcr do
      id { 1 }
    end
  end
end
