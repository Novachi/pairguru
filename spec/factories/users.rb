FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'some_password' }
    confirmed_at { Time.current }
  end
end