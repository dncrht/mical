require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create(:user) }

  it 'has a valid factory' do
    user.should be_valid
  end

  it 'is invalid without email, or invalid email' do
    FactoryGirl.build(:user, email: nil).should_not be_valid

    FactoryGirl.build(:user, email: 'nil@').should_not be_valid
  end

  it 'is invalid without password' do
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end

  it 'accept a blank password if the user exists' do
    user.password = ''
    user.should be_valid
    user.save.should be_true
  end

  it 'is invalid if the email exists' do
    new_user = FactoryGirl.build(:user, email: user.email)
    new_user.should_not be_valid
    new_user.should have(1).error_on(:email)
  end

  it "can't delete the last admin" do
    expect { user.destroy }.to raise_error 'Must be at least one admin'
  end

end
