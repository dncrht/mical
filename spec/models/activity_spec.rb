require 'spec_helper'

describe Activity do

  it 'has a valid factory' do
    FactoryGirl.build(:activity).should be_valid
  end

  it 'is invalid without name' do
    FactoryGirl.build(:activity, name: nil).should_not be_valid
  end

  it 'is invalid without position' do
    FactoryGirl.build(:activity, position: nil).should_not be_valid
  end

  it 'is invalid without unique position' do
    existing_activity = FactoryGirl.create(:activity)
    FactoryGirl.build(:activity, position: existing_activity.position).should_not be_valid
  end

  it 'is invalid without color, or improper color format' do
    FactoryGirl.build(:activity, color: nil).should_not be_valid

    FactoryGirl.build(:activity, color: '#deadbeef').should_not be_valid

    FactoryGirl.build(:activity, color: '##whatever').should_not be_valid

    FactoryGirl.build(:activity, color: '#12345').should_not be_valid
  end

end
