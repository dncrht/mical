FactoryBot.define do
  factory :event do
    day { Date.current }
    description { 'original_description' }
    rating { nil }
    activities_ids { [create(:activity).id] }
  end
end
