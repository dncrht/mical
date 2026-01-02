require 'rails_helper'

RSpec.describe Event do

  let(:event) { create(:event) }

  it 'has a valid factory' do
    expect(event).to be_valid
  end

  it 'is invalid without day' do
    expect(build(:event, day: nil)).to_not be_valid
  end

  it 'day should be unique' do
    event

    expect(build(:event, day: nil)).to have(1).error_on(:day)
  end

  it 'is invalid without activity' do
    expect(build(:event, activity_id: nil)).to_not be_valid
  end

  it 'is invalid without description' do
    expect(build(:event, description: nil)).to_not be_valid
  end

  it 'is invalid with out of range ratings' do
    expect(build(:event, rating: -1)).to_not be_valid
    expect(build(:event, rating: 99)).to_not be_valid
    expect(build(:event, rating: 'x')).to_not be_valid
  end
end
