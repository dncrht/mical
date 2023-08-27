require 'rails_helper'

RSpec.describe MonthCell do
  let(:today) { Date.current }

  it 'is not highlighted' do
    expect(cell(:month, nil, month: 1.month.ago, year: today.year, today: today).month_class).to eq 'month'
    expect(cell(:month, nil, month: today.month, year: 1.year.ago, today: today).month_class).to eq 'month'
  end

  it 'is highlighted' do
    expect(cell(:month, nil, month: today.month, year: today.year, today: today).month_class).to eq 'month month_current'
  end

  it 'creates a sharp gradient' do
    activities = [build(:activity, color: 'red'), build(:activity, color: 'green'), build(:activity, color: 'blue')]
    expect(cell(:month, nil, month: today.month, year: today.year, today: today).background(activities)).to eq 'background: linear-gradient(to right, red 0%, red 33%, green 33%, green 66%, blue 66%)'
  end
end
