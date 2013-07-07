require 'spec_helper'

describe Admin::ActivitiesController do

  before do
    sign_in
  end

  context 'existing activities' do
    let!(:activity) { FactoryGirl.create(:activity) }

    it 'GET index' do
      get :index
      response.should be_success
      assigns(:activities).should_not be_nil
      response.should render_template('index')
    end

    it 'GET show' do
      get :show, :id => activity.id
      response.should redirect_to edit_admin_activity_path(activity.id)
    end

    it 'GET new' do
      get :new
      response.should be_success
      assigns(:activity).should be_an_instance_of Activity
      response.should render_template('new')
    end

    it 'GET edit' do
      get :edit, :id => activity.id
      response.should be_success
      assigns(:activity).should be_an_instance_of Activity
      assigns(:activity).id.should eq activity.id
      response.should render_template('edit')
    end

    it 'PUT update valid' do
      put :update, id: activity.id, activity: activity.attributes
      response.should redirect_to admin_activities_path
    end

    it 'PUT update invalid' do
      activity.name = nil
      put :update, id: activity.id, activity: activity.attributes
      response.should be_success
      assigns(:activity).should be_an_instance_of Activity
      assigns(:activity).id.should eq activity.id
      response.should render_template('edit')
    end

    it 'DELETE destroy' do
      delete :destroy, id: activity.id
      Activity.exists?(activity.id).should be_false
      response.should redirect_to admin_activities_path
    end
  end

  context 'new activity' do
    let(:activity) { FactoryGirl.build(:activity) }

    it 'POST create valid' do
      post :create, activity: activity.attributes
      response.should redirect_to admin_activities_path
    end

    it 'POST create invalid' do
      activity.name = nil
      post :create, activity: activity.attributes
      response.should be_success
      assigns(:activity).should be_an_instance_of Activity
      response.should render_template('new')
    end
  end
end