require 'rails_helper'

describe Event do

  let(:event) { build(:event) }

  it 'has a valid factory' do
    expect(event).to be_valid
  end

  it 'is invalid without day' do
    expect(build(:event, day: nil)).to_not be_valid
  end

  it 'day should be unique' do
    create(:event)

    expect(event).to_not be_valid
    expect(event).to have(1).error_on(:day)
  end

  it 'is invalid without activity' do
    expect(build(:event, activity_id: nil)).to_not be_valid
  end

  it 'is invalid without description' do
    expect(build(:event, description: nil)).to_not be_valid
  end

  it 'should not replace without day' do
    expect(Event.replace(nil, nil, nil)).to be_nil
  end

  it 'should replace when giving a date and the record exists' do
    existing_event = create(:event)

    replacement = Event.replace(existing_event.day, nil, nil)

    expect(replacement).to be_an_instance_of Event
    expect(replacement.description).to be_nil
  end

  it 'should replace when giving a date and the record is new' do
    new_event = build(:event)

    replacement = Event.replace(new_event.day, nil, nil)

    expect(replacement).to be_an_instance_of Event
    expect(replacement.description).to be_nil
  end

  it 'first_year should return current year if there are no events' do
    expect(Event.first_year).to eq Date.current.year
  end

  it 'first_year should return the year of the first event if there are several events' do
    first_event = create(:event, day: '1979-03-12')
    create(:event)

    expect(Event.first_year).to eq first_event.day.year
  end
end
