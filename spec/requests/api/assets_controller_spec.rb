require 'rails_helper'

module Api
  RSpec.describe AssetsController do

    let(:params) { {event_id: event.id, image: fixture_file_upload('spec/fixtures/files/surfer.png')} }
    let(:password) { '123456' }
    let(:admin) { create(:user, password: password) }
    let(:guest) { create(:user, password: password, can_edit_event: false) }
    let(:event) { create(:event) }

    describe 'POST /api/assets' do
      before do
        basic_auth = ActionController::HttpAuthentication::Basic.encode_credentials user.email, password
        post api_assets_path, params: params, headers: {'HTTP_AUTHORIZATION' => basic_auth}
      end

      context 'no auth' do
        let(:user) { double(email: nil) }

        it { expect(response.status).to eq 401 }
      end

      context 'no permission' do
        let(:user) { guest }

        it { expect(response.status).to eq 403 }
      end

      context 'no event' do
        let(:user) { admin }
        let(:event) { double(id: 0) }

        it { expect(response.status).to eq 404 }
      end

      context 'success' do
        let(:user) { admin }

        it { expect(response.status).to eq 200 }
        it { expect(JSON.parse(response.body)).to eq({'id' => Asset.last.id}) }
      end
    end
  end
end
