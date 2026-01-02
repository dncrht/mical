require 'rails_helper'

RSpec.describe EventsController, type: :request do
  let(:today) { Date.current }
  let(:admin) { create(:user) }
  let(:guest) { create(:user, can_edit_event: false) }
  let(:event) { create(:event) }
  let(:activity) { create(:activity) }

  before { log_in user }

  describe '#show' do
    let(:user) { admin }

    it 'prepares an empty form' do
      get event_path(id: '1997-06-04', format: :turbo_stream)

      expect(response.body).to include 'value="1997-06-04"'
    end

    it 'prepares a form for an event' do
      get event_path(id: event.day, format: :turbo_stream)

      expect(response.body).to include %(value="#{Date.current.to_s}")
    end
  end

  describe '#create' do
    before do
      post events_path(format: :turbo_stream), params: {event: build(:event).attributes.merge(activities_ids: [activity.id])}
    end

    context 'when not logged in' do
      let(:user) { nil }

      it { expect(response.status).to eq 403 }
    end

    context "when logged in but can't edit event" do
      let(:user) { guest }

      it { expect(response.status).to eq 403 }
    end

    context 'when logged in and can edit event' do
      let(:user) { admin }

      it { expect(Event.count).to eq 1 }
    end
  end

  describe '#update' do
    before do
      patch event_path(id: event.id, format: :turbo_stream), params: {event: {description: 'different', activities_ids: [activity.id]}}
    end

    context 'when not logged in' do
      let(:user) { nil }

      it { expect(response.status).to eq 403 }
    end

    context "when logged in but can't edit event" do
      let(:user) { guest }

      it { expect(response.status).to eq 403 }
    end

    context 'when logged in and can edit event' do
      let(:user) { admin }

      it { expect(Event.last.description).to eq 'different' }
    end
  end

  describe '#delete' do
    before do
      delete event_path(id: event.id, format: :turbo_stream)
    end

    context 'when not logged in' do
      let(:user) { nil }

      it { expect(Event.exists?(event.id)).to be true }
      it { expect(response.status).to eq 403 }
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
