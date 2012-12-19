require 'spec_helper'

describe Admin::UsersController do

  let(:user) { mock_model(User) }

  before do
    @user = FactoryGirl.create(:user)
    sign_in_as @user
  end

  it 'GET index' do
    get :index
    response.should be_success
    assigns(:users).should_not be_nil
    response.should render_template('index')
  end

  it 'GET show' do
    get :show, :id => @user.id
    response.should redirect_to edit_admin_user_path(@user.id)
  end

  it 'GET new' do
    get :new
    response.should be_success
    assigns(:user).should be_an_instance_of User
    response.should render_template('new')
  end

  it 'POST create' do
    User.stub :new => user
    user.stub :save => true

    post :create, :user => @user.attributes
    response.should redirect_to admin_users_path
  end

  it 'GET edit' do
    User.stub :find => user
    user.stub :save => true
    
    get :edit, :id => user.id
    response.should be_success
    assigns(:user).should be_an_instance_of User
    assigns(:user).id.should eq user.id
    response.should render_template('edit')
  end

  it 'PUT update' do
    User.stub :find => user
    user.stub :update_attributes => true

    put :update, {:id => @user.id, :user => @user.attributes}
    response.should redirect_to admin_users_path
  end
  
  it 'DELETE destroy' do
    User.stub :find => user
    user.stub :destroy => true

    delete :destroy, :id => user.id
    response.should redirect_to admin_users_path
  end

end