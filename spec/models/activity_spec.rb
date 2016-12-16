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
end
