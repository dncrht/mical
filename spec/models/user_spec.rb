require 'spec_helper'

describe User do

  describe '#valid?' do
    subject { build(:user, params) }

    context 'default factory' do
      let(:params) { nil }

      it { should be_valid }
    end

    context 'without email' do
      let(:params) { {email: nil} }

      it { should_not be_valid }
    end

    context 'with invalid email' do
      let(:params) { {email: 'nil@'} }

      it { should_not be_valid }
    end

    context 'without password' do
      let(:params) { {password: nil} }

      it { should_not be_valid }
    end

    context 'is invalid if the email exists' do
      let(:params) { {password: nil} }
      let!(:existing_user) { create(:user, email: subject.email) }

      it { should_not be_valid }
      it { should have(1).error_on(:email) }
    end
  end

  describe '#save' do
    subject { create(:user) }

    context 'accept a blank password if the user exists' do
      before { subject.password = '' }

      it { should be_valid }
      it { expect(subject.save).to eq true }
    end
  end

  describe '#destroy' do
    subject { create(:user) }

    context "can't delete the last admin" do
      it { expect { subject.destroy }.to raise_error 'Must be at least one admin' }
    end
  end
end
