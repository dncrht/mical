FactoryGirl.define do
  
  factory :user do
    email 'admin@domain.tld'
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
    color '#0FF1CE' # A cyan tint in http://en.wikipedia.org/wiki/Hexspeak
  end

  factory :event do
    day Date.today
    activity
    description 'Spent all day testing'
  end

end
