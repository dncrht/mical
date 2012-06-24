class AdminController < ApplicationController
  before_filter :guest_restricted
  skip_before_filter :guest_restricted, :only => :login #same as "return if @_action_name == 'login'"

  def logout
    reset_session

    redirect_to root_path
  end

  def login
    begin
      user = User.find_by_email(params[:email])
      raise if user.password != Digest::MD5.hexdigest(params[:password])

      #ok, usuario logueado
      session[:logged_as] = user
    rescue
      flash[:notice] = 'Login failed'
    end

    redirect_to admin_path
  end

  private
  
  def guest_restricted
    if @logged_as.email == 'guest'
      render '/admin/login', :layout => 'application', :status => 403
      return
    end

    #continue normally
    @activities = Activity.all
  end
end