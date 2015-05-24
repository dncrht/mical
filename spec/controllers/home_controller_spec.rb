require 'rails_helper'

describe HomeController do

  let(:today) { Date.current }
  let(:admin) { build(:user) }
  let(:guest) { build(:user, can_edit_event: false) }
  let!(:event) { create(:event) }

  describe '#index' do
    before { get :index, params }

    context 'rendering current year by default' do
      let(:params) { nil }

      it { expect(assigns(:activities)).to_not be_nil }
      it { expect(assigns(:today)).to eq today }
      it { expect(assigns(:year)).to eq today.year }
      it { expect(assigns(:events)).to eq({event.day.to_s => event}) }
      it { expect(response).to be_success }
      it { expect(response).to render_template 'index' }
    end

    context 'requesting the current year redirects to / to clean the URL' do
      let(:params) { {year: today.year} }

      it { expect(response).to redirect_to root_path }
    end

    context 'rendering the year specified' do
      let(:selected) { rand(1996..2000) }
      let(:params) { {year: selected} }

      it { expect(assigns(:activities)).to_not be_nil }
      it { expect(assigns(:today)).to eq today }
      it { expect(assigns(:year)).to eq selected }
      it { expect(assigns(:events)).to eq Hash.new }
      it { expect(response).to be_success }
      it { expect(response).to render_template 'index' }
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

      it { expect(response).to redirect_to root_path }
    end

    context "when logged in but can't edit event" do
      let(:user) { guest }

      it { expect(response).to redirect_to root_path }
    end

    context 'when logged in and can edit event' do
      let(:user) { admin }
      let(:params) { {day: event.day} }

      it { expect(response).to redirect_to year_path(today.year) }
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

      it { expect(Event.exists?(event.id)).to be_present }
      it { expect(response).to redirect_to root_path }
    end

    context "when logged in but can't edit event" do
      let(:user) { guest }

      it { expect(Event.exists?(event.id)).to be_present }
      it { expect(response).to redirect_to root_path }
    end

    context 'when trying to delete but you not provides a day' do
      let(:user) { guest }
      let(:params) { nil }

      it { expect(Event.exists?(event.id)).to be_present }
      it { expect(response).to redirect_to root_path }
    end

    context 'when logged in and can edit event' do
      let(:user) { admin }

      it { expect(Event.exists?(event.id)).to be_falsey }
      it { expect(response).to redirect_to year_path(today.year) }
    end
  end
end
