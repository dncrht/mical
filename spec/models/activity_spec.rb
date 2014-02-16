require 'spec_helper'

describe Activity do

  describe '#valid?' do
    subject { FactoryGirl.build(:activity, params) }

    context 'default factory' do
      let(:params) { nil }

      it { should be_valid }
    end

    context 'without name' do
      let(:params) { {name: nil} }

      it { should_not be_valid }
    end

    context 'without color' do
      let(:params) { {color: nil} }

      it { should_not be_valid }
    end

    context 'with valid but lengthy characters in color' do
      let(:params) { {color: '#deadbeef'} }

      it { should_not be_valid }
    end

    context 'with invalid characters in color' do
      let(:params) { {color: '##whatever'} }

      it { should_not be_valid }
    end

    context 'with shorter color' do
      let(:params) { {color: '#12345'} }

      it { should_not be_valid }
    end
  end

  it_should_behave_like 'ordenable'
end
