require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#current_user_account' do
    it 'returns user name when a valid user is provided' do
      assign(:current_user, double(email: 'user@domain.com'))

      expect(helper.current_user_account).to eq 'user'
    end

    it 'returns guest user when no user is present' do
      assign(:current_user, nil)

      expect(helper.current_user_account).to eq 'guest'
    end
  end
end
