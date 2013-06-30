require 'spec_helper'

describe Admin::ActivitiesController do

  let(:activity) { FactoryGirl.create(:activity) }

  before do
    sign_in
  end

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

  it 'POST create valid' do
    Activity.any_instance.stub :save => true
    post :create
    response.should redirect_to admin_activities_path
  end

  it 'POST create invalid' do
    Activity.any_instance.stub :save => false
    post :create
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
    Activity.any_instance.stub :update_attributes => true
    put :update, :id => activity.id
    response.should redirect_to admin_activities_path
  end
  
  it 'PUT update invalid' do
    Activity.any_instance.stub :update_attributes => false
    put :update, :id => activity.id
    response.should be_success
    assigns(:activity).should be_an_instance_of Activity
    assigns(:activity).id.should eq activity.id
    response.should render_template('edit')
  end
  
  it 'DELETE destroy' do
    delete :destroy, :id => activity.id
    Activity.exists?(activity.id).should be_false
    response.should redirect_to admin_activities_path
  end

end