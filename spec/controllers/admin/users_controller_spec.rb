require 'rails_helper'

RSpec.describe Admin::UsersController do

  let(:user) { create(:user) }

  before { sign_in_as user }

  context 'with a non admin user' do
    let(:user) { build(:user, is_admin: false) }

    describe '#index' do
      before { get :index }

      it { expect(assigns(:users)).to be_nil }
    end
  end

  context 'with an existing user' do
    let(:other_user) { create(:user) }

    describe '#index' do
      before { get :index }

      it { expect(assigns(:users)).to eq [user] }
      it { expect(response).to render_template 'index' }
    end

    describe '#show' do
      before { get :show, params: {id: user.id} }

      it { expect(response).to redirect_to edit_admin_user_path(user.id) }
    end

    describe '#edit' do
      before { get :edit, params: {id: user.id} }

      it { expect(assigns(:user)).to eq user }
      it { expect(response).to render_template 'edit' }
    end

    describe '#update' do
      before { patch :update, params: {id: other_user.id, user: user_attributes} }

      context 'valid user' do
        let(:user_attributes) { other_user.attributes }

        it { expect(response).to redirect_to admin_users_path }
      end

      context 'invalid user' do
        let(:user_attributes) { other_user.attributes.merge('email' => nil) }

        it { expect(assigns(:user)).to eq other_user }
        it { expect(response).to render_template 'edit' }
      end

      context 'accept a blank password if the user exists' do
        let(:user_attributes) { other_user.attributes.merge('password' => '') }

        it { expect(response).to redirect_to admin_users_path }
      end
    end

    describe '#destroy' do
      # Try to delete other user because he's the last admin
      before { delete :destroy, params: {id: other_user.id} }

      it { expect(response).to redirect_to admin_users_path }
      it { expect(User.exists?(other_user.id)).to be_falsey }
    end
  end

  context 'with a new user' do
    let(:other_user) { build(:user) }

    describe '#new' do
      before { get :new }

      it { expect(assigns(:user)).to be_a User }
      it { expect(response).to render_template 'new' }
    end

    describe '#create' do
      before { post :create, params: {user: user_attributes} }

      context 'valid user' do
        let(:user_attributes) { other_user.attributes.merge('password' => 'any') }

        it { expect(response).to redirect_to admin_users_path }
      end

      context 'invalid user' do
        let(:user_attributes) { other_user.attributes }

        it { expect(assigns(:user)).to be_a User }
        it { expect(response).to render_template 'new' }
      end
    end
  end
end
