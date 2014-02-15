require 'spec_helper'

describe Admin::UsersController do

  let(:user) { FactoryGirl.create(:user) }

  before { sign_in_as user }

  context 'with a non admin user' do
    let(:user) { FactoryGirl.build(:user, is_admin: false) }

    describe '#index' do
      before { get :index }

      its(:response) { should_not be_success }
      it { assigns(:users).should be_nil }
    end
  end

  context 'with an existing user' do
    let(:other_user) { FactoryGirl.create(:user) }

    describe '#index' do
      before { get :index }

      its(:response) { should be_success }
      it { assigns(:users).should eq [user] }
      its(:response) { should render_template 'index' }
    end

    describe '#show' do
      before { get :show, :id => user.id }

      its(:response) { should redirect_to edit_admin_user_path(user.id) }
    end

    describe '#edit' do
      before { get :edit, :id => user.id }

      its(:response) { should be_success }
      it { assigns(:user).should eq user }
      its(:response) { should render_template 'edit' }
    end

    describe '#update' do
      before { put :update, id: other_user.id, user: user_attributes }

      context 'valid user' do
        let(:user_attributes) { other_user.attributes }

        its(:response) { should redirect_to admin_users_path }
      end

      context 'invalid user' do
        let(:user_attributes) { other_user.attributes.merge(email: nil) }

        its(:response) { should be_success }
        it { assigns(:user).should eq other_user }
        its(:response) { should render_template 'edit' }
      end
    end

    describe '#destroy' do
      # Try to delete other user because he's the last admin
      before { delete :destroy, id: other_user.id }

      its(:response) { should redirect_to admin_users_path }
      it { User.exists?(other_user.id).should be_false }
    end
  end

  context 'with a new user' do
    let(:other_user) { FactoryGirl.build(:user) }

    describe '#new' do
      before { get :new }

      its(:response) { should be_success }
      it { assigns(:user).should be_a User }
      its(:response) { should render_template 'new' }
    end

    describe '#create' do
      before { post :create, user: user_attributes }

      context 'valid user' do
        let(:user_attributes) { other_user.attributes.merge(password: 'any') }

        its(:response) { should redirect_to admin_users_path }
      end

      context 'invalid user' do
        let(:user_attributes) { other_user.attributes }

        its(:response) { should be_success }
        it { assigns(:user).should be_a User }
        its(:response) { should render_template 'new' }
      end
    end
  end
end
