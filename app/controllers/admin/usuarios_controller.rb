class Admin::UsuariosController < AdminController
  def index
    @usuarios = Usuario.all
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end
end