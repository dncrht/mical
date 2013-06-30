require 'spec_helper'

describe Admin::UsersController do

  it 'forbidden to non admin users' do
    sign_in_as FactoryGirl.build(:user, is_admin: false)
    get :index
    response.should_not be_success
  end

  context 'properly authenticated' do

    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }

    before do
      sign_in_as user
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
      User.any_instance.stub :save => true
      post :create
      response.should redirect_to admin_users_path
    end

    it 'POST create invalid' do
      User.any_instance.stub :save => false
      post :create
      response.should be_success
      assigns(:user).should be_an_instance_of User
      response.should render_template('new')
    end

    it 'GET edit' do
      get :edit, :id => user.id
      response.should be_success
      assigns(:user).should be_an_instance_of User
      assigns(:user).id.should eq user.id
      response.should render_template('edit')
    end

    it 'PUT update valid' do
      User.any_instance.stub :update_attributes => true
      put :update, :id => user.id
      response.should redirect_to admin_users_path
    end

    it 'PUT update invalid' do
      User.any_instance.stub :update_attributes => false
      put :update, :id => user.id
      response.should be_success
      assigns(:user).should be_an_instance_of User
      assigns(:user).id.should eq user.id
      response.should render_template('edit')
    end

    it 'DELETE destroy' do
      delete :destroy, :id => other_user.id # Try to delete other user because he's the last admin
      User.exists?(other_user.id).should be_false
      response.should redirect_to admin_users_path
    end

  end
end