module Api
  class BaseController < ActionController::API
    include ActionController::HttpAuthentication::Basic::ControllerMethods

    before_action :basic_auth, :only_logged_and_capable

    def basic_auth
      authenticate_or_request_with_http_basic do |user, password|
        @user = User.authenticate(user, password)
        @user.present?
      end
    end

    def only_logged_and_capable
      render status: :forbidden unless @user.can_edit_event
    end
  end
end
