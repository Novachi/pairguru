FactoryBot.define do
  factory :comment do
    association :movie
    association :user
    text { 'some comment' }
  end
end
