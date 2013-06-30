FactoryGirl.define do

  sequence :email do |n|
    "admin#{n}@domain.tld"
  end

  sequence :position do |n|
    n * 10
  end

  factory :user do
    email
    password 'admin'
    can_download true
    can_edit_activity true
    can_edit_event true
    can_see_legend true
    can_see_description true
    is_admin true
  end

  factory :activity do
    name 'Programming'
    position
    color '#0FF1CE' # A cyan tint in http://en.wikipedia.org/wiki/Hexspeak
  end

  factory :event do
    day Date.today
    activity
    description 'Spent all day testing'
  end

end
