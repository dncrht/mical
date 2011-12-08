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
    @usuario.clave = Digest::MD5.hexdigest(@usuario.clave) unless @usuario.clave.blank?

    if @usuario.save
      redirect_to admin_usuarios_path, :notice => 'User created'
    else
      render 'new'
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
    @usuario.clave = ''

    flash[:notice] = 'This is a special user. You can only modify the password.' if @usuario.email == 'admin' or @usuario.email == 'guest'
  end

  def update
    @usuario = Usuario.find(params[:id])

    if @usuario.email == 'admin' or @usuario.email == 'guest'
      params[:usuario] = {:clave => params[:usuario][:clave]} #only password is allowed to be modified
    end

    password = params[:usuario][:clave]
    if password.blank? #if password is left blank, we don't update it
      params[:usuario].delete :clave
    else #if password is set, we modify current password
      params[:usuario][:clave] = Digest::MD5.hexdigest(password)
    end

    if @usuario.update_attributes(params[:usuario])
      redirect_to admin_usuarios_path, :notice => 'User created'
    else
      @usuario.clave = ''
      render 'edit'
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])

    redirect_to admin_usuarios_path, :notice => 'User cannot be deleted' and return if @usuario.email == 'admin' or @usuario.email == 'guest'

    @usuario.delete
    redirect_to admin_usuarios_path, :notice => 'User deleted'
  end

  private
  def restricted
    render :status => 403 if @logged_as.email != 'admin'

    @tab = :users
  end
end