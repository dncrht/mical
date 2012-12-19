require 'spec_helper'

describe Admin::ActivitiesController do

  let(:activity) { mock_model(Activity) }

  before do
    sign_in

    Activity.stub(:find).and_return(activity)
    Activity.stub(:new).and_return(activity)
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
    activity.stub :save => true

    post :create, :activity => {}
    response.should redirect_to admin_activities_path
  end

  it 'POST create invalid' do
    activity.stub :save => false

    post :create, :activity => {}
    response.should be_success
    assigns(:activity).should be_an_instance_of Activity
    response.should render_template('new')
  end
  
  it 'GET edit' do
    activity.stub :save => true
    
    get :edit, :id => activity.id
    response.should be_success
    assigns(:activity).should be_an_instance_of Activity
    assigns(:activity).id.should eq activity.id
    response.should render_template('edit')
  end

  it 'PUT update valid' do
    activity.stub :update_attributes => true

    put :update, {:id => activity.id, :activity => {}} # Don't care about the attributes because we are not testing the model
    response.should redirect_to admin_activities_path
  end
  
  it 'PUT update invalid' do
    activity.stub :update_attributes => false

    put :update, {:id => activity.id, :activity => {}}
    response.should be_success
    assigns(:activity).should be_an_instance_of Activity
    assigns(:activity).id.should eq activity.id
    response.should render_template('edit')
  end
  
  it 'DELETE destroy' do
    activity.stub :destroy => true

    delete :destroy, :id => activity.id
    response.should redirect_to admin_activities_path
  end

end