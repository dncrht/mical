class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :strip_parameters

  def require_login
    redirect_to new_sessions_path unless current_user
  end

  def log_in(id)
    session[:user_id] = id
  end

  def log_out
    session.delete :user_id
  end

  def current_user
    return if session[:user_id].blank?

    user = User.find_by(id: session[:user_id])
    return unless user

    @_current_user ||= user
  end
  helper_method :current_user

  def strip_parameters
    stripper = lambda do |seed|
      if seed.respond_to?(:to_h)
        seed.each { |key, value| stripper.call(value || key) }
      elsif seed.respond_to?(:strip) && !seed.frozen?
        seed.strip!
      end
    end
    stripper.call(params)
  end
end
