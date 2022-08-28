require 'rails_helper'

RSpec.describe EventsController, type: :request do

  let(:today) { Date.current }
  let(:admin) { create(:user) }
  let(:guest) { create(:user, can_edit_event: false) }
  let!(:event) { create(:event) }

  describe '#show' do
    it 'prepares an empty form' do
      get event_path(as: admin, id: '1997-06-04'), headers: {'ACCEPT' => 'application/javascript'}

      expect(response.body).to include 'value=\"1997-06-04\"'
    end

    it 'prepares a form for an event' do
      get event_path(as: admin, id: event.day), headers: {'ACCEPT' => 'application/javascript'}

      expect(response.body).to include %(value=\\"#{Date.current.to_s}\\")
    end
  end

  describe '#create' do
    before do
      post events_path(as: user), params: {event: event.attributes}, headers: {'ACCEPT' => 'application/javascript'}
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

      it { expect(Event.count).to eq 1 }
    end
  end

  describe '#update' do
    before do
      patch event_path(as: user, id: event.id), params: {event: {description: 'different'}}, headers: {'ACCEPT' => 'application/javascript'}
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

      it { expect(Event.last.description).to eq 'different' }
    end
  end

  describe '#delete' do
    before do
      delete event_path(as: user, id: event.id), headers: {'ACCEPT' => 'application/javascript'}
    end

    context 'when not logged in' do
      let(:user) { nil }

      it { expect(Event.exists?(event.id)).to be true }
      it { expect(response).to redirect_to root_path }
    end

    context "when logged in but can't edit event" do
      let(:user) { guest }

      it { expect(Event.exists?(event.id)).to be true }
    end

    context 'when logged in and can edit event' do
      let(:user) { admin }

      it { expect(Event.exists?(event.id)).to be false }
    end
  end
end
