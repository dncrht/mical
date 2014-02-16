require 'spec_helper'

describe Event do

  let(:event) { build(:event) }

  it 'has a valid factory' do
    event.should be_valid
  end

  it 'is invalid without day' do
    build(:event, day: nil).should_not be_valid
  end

  it 'day should be unique' do
    create(:event)

    event.should_not be_valid
    event.should have(1).error_on(:day)
  end

  it 'is invalid without activity' do
    build(:event, activity_id: nil).should_not be_valid
  end

  it 'is invalid without description' do
    build(:event, description: nil).should_not be_valid
  end

  it 'should not replace without day' do
    Event.replace(nil, nil, nil).should be_nil
  end

  it 'should replace when giving a date and the record exists' do
    existing_event = create(:event)

    replacement = Event.replace(existing_event.day, nil, nil)

    replacement.should be_an_instance_of Event
    replacement.description.should be_nil
  end

  it 'should replace when giving a date and the record is new' do
    new_event = build(:event)

    replacement = Event.replace(new_event.day, nil, nil)

    replacement.should be_an_instance_of Event
    replacement.description.should be_nil
  end

  it 'first_year should return current year if there are no events' do
    Event.first_year.should eq Date.current.year
  end

  it 'first_year should return the year of the first event if there are several events' do
    first_event = create(:event, day: '1979-03-12')
    create(:event)

    Event.first_year.should eq first_event.day.year
  end
end