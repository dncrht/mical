class Admin::UsuariosController < AdminController
  before_filter :restricted

  def index
    @usuarios = Usuario.all
  end

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(params[:usuario])

    if @usuario.save
      redirect_to admin_usuarios_path, :notice => 'User created'
    else
      render 'new'
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])

    redirect_to admin_usuarios_path, :notice => 'User cannot be modified' if @usuario.email == 'admin' or @usuario.email == 'guest'
  end

  def update
    @usuario = Usuario.find(params[:id])

    if @usuario.update_attributes(params[:usuario])
      redirect_to admin_usuarios_path, :notice => 'User created'
    else
      render 'edit'
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])

    redirect_to admin_usuarios_path, :notice => 'User cannot be modified' and return if @usuario.email == 'admin' or @usuario.email == 'guest'

    @usuario.delete
    redirect_to admin_usuarios_path, :notice => 'User deleted'
  end

  private
  def restricted
    render :status => 403 if @logged_as.email != 'admin'
  end
end