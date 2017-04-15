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
end
