require 'rails_helper'

describe Admin::ActivitiesController do

  before { sign_in }

  context 'with an existing activity' do
    let!(:activity) { create(:activity) }

    describe '#index' do
      before { get :index }

      it { expect(response).to be_success }
      it { expect(assigns(:activities)).to eq [activity] }
      it { expect(response).to render_template 'index' }
    end

    describe '#show' do
      before { get :show, :id => activity.id }

      it { expect(response).to redirect_to edit_admin_activity_path(activity.id) }
    end

    describe '#edit' do
      before { get :edit, :id => activity.id }

      it { expect(response).to be_success }
      it { expect(assigns(:activity)).to eq activity }
      it { expect(response).to render_template 'edit' }
    end

    describe '#update' do
      before { put :update, id: activity.id, activity: activity_attributes }

      context 'valid activity'  do
        let(:activity_attributes) { activity.attributes }

        it { expect(response).to redirect_to admin_activities_path }
      end

      context 'invalid activity' do
        let(:activity_attributes) { activity.attributes.merge(name: nil) }

        it { expect(response).to be_success }
        it { expect(assigns(:activity)).to eq activity }
        it { expect(response).to render_template 'edit' }
      end
    end

    describe '#destroy' do
      before { delete :destroy, id: activity.id }

      it { expect(response).to redirect_to admin_activities_path }
      it { expect(Activity.exists?(activity.id)).to be_falsey }
    end
  end

  context 'with a new activity' do
    let(:activity) { build(:activity) }

    describe '#new' do
      before { get :new }

      it { expect(response).to be_success }
      it { expect(assigns(:activity)).to be_an Activity }
      it { expect(response).to render_template 'new' }
    end

    describe '#create' do
      before { post :create, activity: activity_attributes }

      context 'valid activity' do
        let(:activity_attributes) { activity.attributes }

        it { expect(response).to redirect_to admin_activities_path }
      end

      context 'invalid activity' do
        let(:activity_attributes) { activity.attributes.merge(name: nil) }

        it { expect(response).to be_success }
        it { expect(assigns(:activity)).to be_an Activity }
        it { expect(response).to render_template 'new' }
      end
    end
  end
end
