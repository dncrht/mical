require 'rails_helper'

RSpec.describe EventsController do

  let(:today) { Date.current }
  let(:admin) { build(:user) }
  let(:guest) { build(:user, can_edit_event: false) }
  let!(:event) { create(:event) }

  describe '#show' do
    before { sign_in_as admin }

    it 'prepares an empty form' do
      get :show, xhr: true, params: {id: '1997-06-04'}, format: :js

      expect(assigns(:activities)).to eq [event.activity]
      expect(assigns(:event).id).to be_nil
    end

    it 'prepares a form for an event' do
      get :show, xhr: true, params: {id: event.day}, format: :js

      expect(assigns(:activities)).to eq [event.activity]
      expect(assigns(:event)).to eq event
    end
  end

  describe '#create' do
    before do
      event = build(:event)
      sign_in_as user
      post :create, params: {id: event.day, event: event.attributes}
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

      it { expect(response).to redirect_to year_path(today.year) }
    end
  end

  describe '#update' do
    before do
      sign_in_as user
      patch :update, params: {id: event.id, event: {description: 'different'}}
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

      it { expect(response).to redirect_to year_path(today.year) }
    end
  end

  describe '#delete' do
    before do
      sign_in_as user
      delete :destroy, params: {id: event.id}
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

    context 'when logged in and can edit event' do
      let(:user) { admin }

      it { expect(Event.exists?(event.id)).to be_falsey }
      it { expect(response).to redirect_to year_path(today.year) }
    end
  end
end
