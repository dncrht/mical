require 'rails_helper'

describe User do

  describe '#valid?' do
    subject { build(:user, params) }

    context 'default factory' do
      let(:params) { nil }

      it { is_expected.to be_valid }
    end

    context 'without email' do
      let(:params) { {email: nil} }

      it { is_expected.to_not be_valid }
    end

    context 'with invalid email' do
      let(:params) { {email: 'nil@'} }

      it { is_expected.to_not be_valid }
    end

    context 'without password' do
      let(:params) { {password: nil} }

      it { is_expected.to_not be_valid }
    end

    context 'is invalid if the email exists' do
      let(:params) { {password: nil} }
      let!(:existing_user) { create(:user, email: subject.email) }

      it { is_expected.to_not be_valid }
      it { is_expected.to have(1).error_on(:email) }
    end
  end

  describe '#destroy' do
    subject { create(:user) }

    context "can't delete the last admin" do
      it { expect { subject.destroy }.to raise_error 'Must be at least one admin' }
    end
  end
end
