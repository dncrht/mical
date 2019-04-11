FactoryBot.define do
  factory :event do
    day { Date.current }
    association :activity
    description { 'original_description' }
    rating { nil }
  end
end
