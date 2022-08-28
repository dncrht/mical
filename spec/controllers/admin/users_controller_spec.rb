require 'rails_helper'

RSpec.describe Admin::UsersController, type: :request do

  let(:user) { create(:user) }

  context 'with a non admin user' do
    let(:user) { create(:user, is_admin: false) }

    describe '#index' do
      before { get admin_users_path(as: user) }

      it { expect(response.status).to eq 403 }
    end
  end

  context 'with an existing user' do
    let(:other_user) { create(:user) }

    describe '#index' do
      before { get admin_users_path(as: user) }

      specify do
        expect(response.body).to have_link('Users', class: 'active')
        expect(response.body).to have_link('New user')
        expect(response.body).to have_text('@domain.tld')
      end
    end

    describe '#show' do
      before { get admin_user_path(as: user, id: user.id) }

      it { expect(response).to redirect_to edit_admin_user_path(user.id) }
    end

    describe '#edit' do
      before { get edit_admin_user_path(as: user, id: user.id) }

      specify do
        expect(response.body).to have_link('Users', class: 'active')
        expect(response.body).to have_text('Edit user')
        expect(response.body).to have_css('span.uneditable-input', exact_text: user.email)
      end
    end

    describe '#update' do
      before { patch admin_user_path(as: user, id: user_attributes['id']), params: {user: user_attributes} }

      context 'valid user' do
        let(:user_attributes) { other_user.attributes }

        it { expect(response).to redirect_to admin_users_path }
      end

      context 'invalid user' do
        let(:user_attributes) { other_user.attributes.merge('email' => nil) }

        it { expect(response.body).to have_text('Edit user') }
      end

      context 'accept a blank password if the user exists' do
        let(:user_attributes) { other_user.attributes.merge('password' => '') }

        it { expect(response).to redirect_to admin_users_path }
      end
    end

    describe '#destroy' do
      # Try to delete other user because he's the last admin
      before { delete admin_user_path(as: user, id: other_user.id) }

      it { expect(response).to redirect_to admin_users_path }
      it { expect(User.exists?(other_user.id)).to be false }
    end
  end

  context 'with a new user' do
    let(:other_user) { build(:user) }

    describe '#new' do
      before { get new_admin_user_path(as: user) }

      it { expect(response.body).to have_text('New user') }
    end

    describe '#create' do
      before { post admin_users_path(as: user), params: {user: user_attributes} }

      context 'valid user' do
        let(:user_attributes) { other_user.attributes.merge('password' => 'any') }

        it { expect(response).to redirect_to admin_users_path }
      end

      context 'invalid user' do
        let(:user_attributes) { other_user.attributes }

        it { expect(response.body).to have_text('New user') }
      end
    end
  end
end
