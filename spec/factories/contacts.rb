FactoryGirl.define do
  factory :contact do
    id { '-Kh-cQRNupsqgLBbRdJX' }
    name { Faker::GameOfThrones.character }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    street_address { Faker::Address.street_address }
    secondary_address { Faker::Address.secondary_address }
    building_number { Faker::Address.building_number }
    zip_code { Faker::Address.zip_code }
  end
end
