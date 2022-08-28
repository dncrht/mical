require 'rails_helper'

RSpec.describe Admin::ActivitiesController, type: :request do

  let(:user) { create(:user) }

  context 'with an existing activity' do
    let!(:activity) { create(:activity) }

    describe '#index' do
      before { get admin_activities_path(as: user) }

      specify do
        expect(response.body).to have_link('Activities', class: 'active')
        expect(response.body).to have_link('New activity')
        expect(response.body).to have_text('Programming')
        expect(response.body).to have_text('#0FF1CE')
      end
    end

    describe '#show' do
      before { get admin_activity_path(as: user,id: activity.id) }

      it { expect(response).to redirect_to edit_admin_activity_path(activity.id) }
    end

    describe '#edit' do
      before { get edit_admin_activity_path(as: user, id: activity.id) }

      specify do
        expect(response.body).to have_link('Activities', class: 'active')
        expect(response.body).to have_text('Edit activity')
        expect(response.body).to have_css('input[value="Programming"]')
      end
    end

    describe '#update' do
      before { patch admin_activity_path(as: user, id: activity.id), params: {activity: activity_attributes} }

      context 'valid activity'  do
        let(:activity_attributes) { activity.attributes }

        it { expect(response).to redirect_to admin_activities_path }
      end

      context 'invalid activity' do
        let(:activity_attributes) { activity.attributes.merge('name' => nil) }

        it { expect(response.body).to have_text('Edit activity') }
      end
    end

    describe '#destroy' do
      before { delete admin_activity_path(as: user, id: activity.id) }

      it { expect(response).to redirect_to admin_activities_path }
      it { expect(Activity.exists?(activity.id)).to be false }
    end
  end

  context 'with a new activity' do
    let(:activity) { build(:activity) }

    describe '#new' do
      before { get new_admin_activity_path(as: user) }

      it { expect(response.body).to have_text('New activity') }
    end

    describe '#create' do
      before { post admin_activities_path(as: user), params: {activity: activity_attributes} }

      context 'valid activity' do
        let(:activity_attributes) { activity.attributes }

        it { expect(response).to redirect_to admin_activities_path }
      end

      context 'invalid activity' do
        let(:activity_attributes) { activity.attributes.merge('name' => nil) }

        it { expect(response.body).to have_text('New activity') }
      end
    end
  end
end
