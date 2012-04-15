class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :who_am_i

  def who_am_i
    return if params[:action] == 'login' #al intertar loguearse no determina usuario

    begin
      @logged_as = Usuario.find(session[:logged_as])
    rescue
      @logged_as = Usuario.find_by_email('guest') #si no estoy logueado, soy invitado
    end

    #sigue con lo que estaba haciendo
    @actividades = Actividad.order('nombre')
  end
end