require 'rails_helper'

RSpec.describe HomeController do

  let(:today) { Date.current }
  let(:admin) { build(:user) }
  let(:guest) { build(:user, can_edit_event: false) }
  let!(:event) { create(:event) }

  describe '#index' do
    before { get :index, params: params }

    context 'rendering current year by default' do
      let(:params) { {} }

      it { expect(assigns(:activities)).to_not be_nil }
      it { expect(assigns(:today)).to eq today }
      it { expect(assigns(:year)).to eq today.year }
      it { expect(assigns(:events)).to eq({event.day.to_s => event}) }
      it { expect(response).to render_template 'index' }
    end

    context 'requesting the current year redirects to / to clean the URL' do
      let(:params) { {year: today.year} }

      it { expect(response).to redirect_to root_path }
    end

    context 'rendering the year specified' do
      let(:selected) { rand(1996..2000) }
      let(:params) { {year: selected} }

      it { expect(assigns(:activities)).to_not be_nil }
      it { expect(assigns(:today)).to eq today }
      it { expect(assigns(:year)).to eq selected }
      it { expect(assigns(:events)).to eq Hash.new }
      it { expect(response).to render_template 'index' }
    end
  end
end
