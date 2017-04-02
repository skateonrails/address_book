FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'PaSSw0rD!!1!!'
    password_confirmation 'PaSSw0rD!!1!!'
  end
end
