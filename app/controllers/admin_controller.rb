class AdminController < ApplicationController
  def index
    @usuarios = Usuario.order('email')

    @actividades = Actividad.order('nombre')
  end
end
