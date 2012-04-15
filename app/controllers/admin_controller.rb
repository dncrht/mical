class AdminController < ApplicationController
  before_filter :guest_restricted
  skip_before_filter :guest_restricted, :only => :login #same as return if @_action_name == 'login'

  def logout
    reset_session

    redirect_to root_path
  end

  def login
    begin
      usuario = Usuario.find_by_email(params[:email])
      raise if usuario.clave != Digest::MD5.hexdigest(params[:clave])

      #ok, usuario logueado
      session[:logged_as] = usuario
    rescue
      flash[:notice] = 'Login incorrecto'
    end

    redirect_to admin_path
  end

  private
  def guest_restricted
    if @logged_as.email == 'guest'
      render '/admin/login', :layout => 'application', :status => 403
      return
    end

    #go on
    @actividades = Actividad.all
  end
end