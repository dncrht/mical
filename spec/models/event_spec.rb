require 'rails_helper'

RSpec.describe Event do

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

  it 'first_year should return current year if there are no events' do
    expect(Event.first_year).to eq Date.current.year
  end

  it 'first_year should return the year of the first event if there are several events' do
    first_event = create(:event, day: '1979-03-12')
    create(:event)

    expect(Event.first_year).to eq first_event.day.year
  end
end
