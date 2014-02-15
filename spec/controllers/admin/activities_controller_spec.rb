require 'spec_helper'

describe Admin::ActivitiesController do

  before { sign_in }

  context 'with an existing activity' do
    let!(:activity) { FactoryGirl.create(:activity) }

    describe '#index' do
      before { get :index }

      its(:response) { should be_success }
      it { assigns(:activities).should eq [activity] }
      its(:response) { should render_template 'index' }
    end

    describe '#show' do
      before { get :show, :id => activity.id }

      its(:response) { should redirect_to edit_admin_activity_path(activity.id) }
    end

    describe '#edit' do
      before { get :edit, :id => activity.id }

      its(:response) { should be_success }
      it { assigns(:activity).should eq activity }
      its(:response) { should render_template 'edit' }
    end

    describe '#update' do
      before { put :update, id: activity.id, activity: activity_attributes }

      context 'valid activity'  do
        let(:activity_attributes) { activity.attributes }

        its(:response) { should redirect_to admin_activities_path }
      end

      context 'invalid activity' do
        let(:activity_attributes) { activity.attributes.merge(name: nil) }

        its(:response) { should be_success }
        it { assigns(:activity).should eq activity }
        its(:response) { should render_template 'edit' }
      end
    end

    describe '#destroy' do
      before { delete :destroy, id: activity.id }

      its(:response) { should redirect_to admin_activities_path }
      it { Activity.exists?(activity.id).should be_false }
    end
  end

  context 'with a new activity' do
    let(:activity) { FactoryGirl.build(:activity) }

    describe '#new' do
      before { get :new }

      its(:response) { should be_success }
      it { assigns(:activity).should be_an Activity }
      its(:response) { should render_template 'new' }
    end

    describe '#create' do
      before { post :create, activity: activity_attributes }

      context 'valid activity' do
        let(:activity_attributes) { activity.attributes }

        its(:response) { should redirect_to admin_activities_path }
      end

      context 'invalid activity' do
        let(:activity_attributes) { activity.attributes.merge(name: nil) }

        its(:response) { should be_success }
        it { assigns(:activity).should be_an Activity }
        its(:response) { should render_template 'new' }
      end
    end
  end
end
