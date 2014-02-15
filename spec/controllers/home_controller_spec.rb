require 'spec_helper'

describe HomeController do

  let(:today) { Date.current }
  let(:admin) { FactoryGirl.build(:user) }
  let(:guest) { FactoryGirl.build(:user, can_edit_event: false) }
  let!(:event) { FactoryGirl.create(:event) }

  describe '#index' do
    before { get :index, params }

    context 'rendering current year by default' do
      let(:params) { nil }

      it { assigns(:activities).should_not be_nil }
      it { assigns(:today).should eq today }
      it { assigns(:year).should eq today.year }
      it { assigns(:events).should eq({event.day.to_s => event}) }
      its(:response) { should be_success }
      its(:response) { should render_template 'index' }
    end

    context 'requesting the current year redirects to / to clean the URL' do
      let(:params) { {year: today.year} }

      its(:response) { should redirect_to root_path }
    end

    context 'rendering the year specified' do
      let(:selected) { rand(1996..2000) }
      let(:params) { {year: selected} }

      it { assigns(:activities).should_not be_nil }
      it { assigns(:today).should eq today }
      it { assigns(:year).should eq selected }
      it { assigns(:events).should eq Hash.new }
      its(:response) { should be_success }
      its(:response) { should render_template 'index' }
    end
  end

  describe '#replace' do
    let(:params) { nil }
    before do
      sign_in_as user
      put :replace, params
    end

    context 'when not logged in' do
      let(:user) { nil }

      its(:response) { should redirect_to root_path }
    end

    context "when logged in but can't edit event" do
      let(:user) { guest }

      its(:response) { should redirect_to root_path }
    end

    context 'when logged in and can edit event' do
      let(:user) { admin }
      let(:params) { {day: event.day} }

      its(:response) { should redirect_to "#{root_path}#{today.year}" }
    end
  end

  describe '#delete' do
    let(:params) { {day: event.day} }
    before do
      sign_in_as user
      delete :destroy, params
    end

    context 'when not logged in' do
      let(:user) { nil }

      it { Event.exists?(event.id).should be_true }
      its(:response) { should redirect_to root_path }
    end

    context "when logged in but can't edit event" do
      let(:user) { guest }

      it { Event.exists?(event.id).should be_true }
      its(:response) { should redirect_to root_path }
    end

    context 'when trying to delete but you not provides a day' do
      let(:user) { guest }
      let(:params) { nil }

      it { Event.exists?(event.id).should be_true }
      its(:response) { should redirect_to root_path }
    end

    context 'when logged in and can edit event' do
      let(:user) { admin }

      it { Event.exists?(event.id).should be_false }
      its(:response) { should redirect_to "#{root_path}#{today.year}" }
    end
  end
end
