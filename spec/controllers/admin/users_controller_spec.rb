require 'spec_helper'

describe Admin::UsersController do

  it 'forbidden to non admin users' do
    sign_in_as FactoryGirl.build(:user, is_admin: false)
    get :index
    response.should_not be_success
  end
end

describe Admin::UsersController, 'properly authenticated' do

  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in_as user
  end

  context 'existing user' do
    let!(:other_user) { FactoryGirl.create(:user) }

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

    it 'GET edit' do
      get :edit, id: user.id
      response.should be_success
      assigns(:user).should be_an_instance_of User
      assigns(:user).id.should eq user.id
      response.should render_template('edit')
    end

    it 'PUT update valid' do
      put :update, id: other_user.id, user: other_user.attributes
      response.should redirect_to admin_users_path
    end

    it 'PUT update invalid' do
      other_user.email = nil
      put :update, id: other_user.id, user: other_user.attributes
      response.should be_success
      assigns(:user).should be_an_instance_of User
      assigns(:user).id.should eq other_user.id
      response.should render_template('edit')
    end

    it 'DELETE destroy' do
      delete :destroy, id: other_user.id # Try to delete other user because he's the last admin
      User.exists?(other_user.id).should be_false
      response.should redirect_to admin_users_path
    end
  end

  context 'new user' do
    let(:other_user) { FactoryGirl.build(:user) }

    it 'GET new' do
      get :new
      response.should be_success
      assigns(:user).should be_an_instance_of User
      response.should render_template('new')
    end

    it 'POST create valid' do
      post :create, user: other_user.attributes.merge(password: 'any')
      response.should redirect_to admin_users_path
    end

    it 'POST create invalid' do
      other_user.email = nil
      post :create, user: other_user.attributes
      response.should be_success
      assigns(:user).should be_an_instance_of User
      response.should render_template('new')
    end
  end
end