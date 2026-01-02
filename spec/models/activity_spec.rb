require 'rails_helper'

RSpec.describe Activity do

  describe '#valid?' do
    subject { build(:activity, params) }

    context 'default factory' do
      let(:params) { nil }

      it { is_expected.to be_valid }
    end

    context 'without name' do
      let(:params) { {name: nil} }

      it { is_expected.to_not be_valid }
    end

    context 'without color' do
      let(:params) { {color: nil} }

      it { is_expected.to_not be_valid }
    end

    context 'with valid but lengthy characters in color' do
      let(:params) { {color: '#deadbeef'} }

      it { is_expected.to_not be_valid }
    end

    context 'with invalid characters in color' do
      let(:params) { {color: '##whatever'} }

      it { is_expected.to_not be_valid }
    end

    context 'with shorter color' do
      let(:params) { {color: '#12345'} }

      it { is_expected.to_not be_valid }
    end
  end

  it_should_behave_like 'sortable'

  describe '#count_during_year' do
    it 'counts the number of activities the given year' do
      activity = create(:activity)
      create(:event, day: '2000-01-01', activities_ids: [activity.id])
      create(:event, day: '2000-12-31', activities_ids: [activity.id])

      expect(activity.count_during_year(2000)).to eq 2
    end
  end
end
