FactoryGirl.define do

  sequence :email do |n|
    "admin#{n}@domain.tld"
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
end