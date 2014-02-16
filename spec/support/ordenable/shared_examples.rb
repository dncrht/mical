require 'spec_helper'

shared_examples 'ordenable' do

  let(:tested_model) { described_class.name.downcase }
  let(:params) { {position: nil} }
  let!(:model) { FactoryGirl.create(tested_model, params) }

  context 'set position to max position plus 10 if position is not specified' do
    it { expect(model.position).to eq 10 }
    it { expect(model).to be_valid }
  end

  context 'reordering in multiples of 10 after inserting a multiple of 5' do
    let!(:new_model) { FactoryGirl.create(tested_model, position: 5) }

    it { expect(new_model.reload.position).to eq 10 }
    it { expect(model.reload.position).to eq 20 }
  end

  context 'valid if position is multiple of 5' do
    let(:params) { {position: 15} }

    it { expect(model).to be_valid }
  end

  context 'invalid if position is not multiple of 5' do
    let(:params) { {position: 12} }

    it { expect(model).not_to be_valid }
    it { expect(model).to have(1).error_on(:position) }
  end
end
