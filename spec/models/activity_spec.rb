require 'spec_helper'

describe Activity do

  it 'has a valid factory' do
    FactoryGirl.build(:activity).should be_valid
  end

  it 'is invalid without name' do
    FactoryGirl.build(:activity, name: nil).should_not be_valid
  end

  it 'is invalid without color, or improper color format' do
    FactoryGirl.build(:activity, color: nil).should_not be_valid

    FactoryGirl.build(:activity, color: '#deadbeef').should_not be_valid

    FactoryGirl.build(:activity, color: '##whatever').should_not be_valid

    FactoryGirl.build(:activity, color: '#12345').should_not be_valid
  end

  context 'ordenable' do

    it 'if position is not specified should set position to max position plus 10' do
      FactoryGirl.create(:activity, position: nil).position.should eq 10
    end

    it 'should reorder positions in multiples of 10 to allow multiples of 5 to be reordered' do
      # There's a reexisting activity
      FactoryGirl.create(:activity, position: 10, name: 'existing')

      # And we insert a new one
      FactoryGirl.create(:activity, position: 5, name: 'new')

      # Activities are reordered
      Activity.find_by_name('new').position.should eq 10
      Activity.find_by_name('existing').position.should eq 20
    end

    it 'is valid if position is multiple of 5' do
      FactoryGirl.build(:activity, position: 10).should be_valid
      FactoryGirl.build(:activity, position: 15).should be_valid
    end

    it 'is invalid if position is not multiple of 5' do
      FactoryGirl.create(:activity, position: 12).should have(1).error_on(:position)
    end
  end
end