require 'rails_helper'

RSpec.describe HomeController, type: :request do

  let(:today) { Date.current }
  let(:admin) { build(:user) }
  let(:guest) { build(:user, can_edit_event: false) }
  let(:event) { create(:event) }
  let(:path) { root_path }
  let(:params) { {} }

  describe '#index' do
    before do
      event
      Timecop.travel('1995-12-16') { get path, params: params }
    end

    context 'rendering current year by default' do
      specify do
        expect(response.body).to have_css('span.header-year', exact_text: '1995')
        expect(response.body).to have_css('p.header-month', exact_text: 'December')
      end
    end

    context 'requesting the current year redirects to / to clean the URL' do
      let(:path) { '/1995' }

      it { expect(response).to redirect_to root_path }
    end

    context 'rendering the year specified' do
      let(:params) { {year: '2004'} }

      specify do
        expect(response.body).to have_css('span.header-year', exact_text: '2004')
        expect(response.body).to have_css('p.header-month', exact_text: 'December')
      end
    end
  end
end
