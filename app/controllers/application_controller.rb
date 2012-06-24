class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :who_am_i
  skip_before_filter :who_am_i, :only => :login #skip user identification when trying to log in

  def who_am_i
    begin
      @logged_as = User.find(session[:logged_as])
    rescue
      @logged_as = User.find_by_email('guest') #if i'm not logged in, i'm a guest
    end

    #continue normally
    @activities = Activity.all
  end
end