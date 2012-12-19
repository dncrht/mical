require 'spec_helper'

describe Admin::UsersController do

  let(:user) { mock_model(User) }

  before do
    sign_in

    User.stub(:find).and_return(user)
    User.stub(:new).and_return(user)
  end

  it 'GET index' do
    get :index
    response.should be_success
    assigns(:users).should_not be_nil
    response.should render_template('index')
  end

  it 'GET show' do
    get :show, :id => user.id
    response.should redirect_to edit_admin_user_path(user.id)
  end

  it 'GET new' do
    get :new
    response.should be_success
    assigns(:user).should be_an_instance_of User
    response.should render_template('new')
  end

  it 'POST create valid' do
    user.stub :save => true

    post :create, :user => {}
    response.should redirect_to admin_users_path
  end

  it 'POST create invalid' do
    user.stub :save => false

    post :create, :user => {}
    response.should be_success
    assigns(:user).should be_an_instance_of User
    response.should render_template('new')
  end
  
  it 'GET edit' do
    user.stub :save => true
    
    get :edit, :id => user.id
    response.should be_success
    assigns(:user).should be_an_instance_of User
    assigns(:user).id.should eq user.id
    response.should render_template('edit')
  end

  it 'PUT update valid' do
    user.stub :update_attributes => true

    put :update, {:id => user.id, :user => {}} # Don't care about the attributes because we are not testing the model
    response.should redirect_to admin_users_path
  end
  
  it 'PUT update invalid' do
    user.stub :update_attributes => false

    put :update, {:id => user.id, :user => {}}
    response.should be_success
    assigns(:user).should be_an_instance_of User
    assigns(:user).id.should eq user.id
    response.should render_template('edit')
  end
  
  it 'DELETE destroy' do
    user.stub :destroy => true

    delete :destroy, :id => user.id
    response.should redirect_to admin_users_path
  end

end