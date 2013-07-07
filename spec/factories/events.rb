FactoryGirl.define do

  factory :event do
    day Date.current
    activity
    description 'original_description'
  end
end