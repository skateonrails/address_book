FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'PaSSw0rD!!1!!'
    factory :admin_user do
      is_admin true
    end
  end
end
