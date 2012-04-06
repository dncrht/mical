class Admin::UsuariosController < AdminController
  before_filter :restricted

  def index
    @usuarios = Usuario.order('email')
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
      @usuario.clave = ''
      render 'new'
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])

    redirect_to admin_usuarios_path, :alert => 'User cannot be edited' and return if @usuario.email == 'guest'

    @usuario.clave = ''
  end

  def update
    @usuario = Usuario.find(params[:id])

    redirect_to admin_usuarios_path, :alert => 'User cannot be edited' and return if @usuario.email == 'guest'

    if @usuario.email == 'admin'
      params[:usuario] = {:clave => params[:usuario][:clave]} #the only field allowing modification is password
    end

    password = params[:usuario][:clave]
    if password.blank? #if password is left blank, we don't update it
      params[:usuario].delete :clave
    else #if password is set, we modify current password
      params[:usuario][:clave] = Digest::MD5.hexdigest(password)
    end

    if @usuario.update_attributes(params[:usuario])
      if password.blank? and @usuario.email == 'admin'
        redirect_to admin_usuarios_path, :notice => 'User not modified'
      else
        redirect_to admin_usuarios_path, :notice => 'User updated'
      end
    else
      @usuario.clave = ''
      render 'edit'
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])

    redirect_to admin_usuarios_path, :alert => 'User cannot be deleted' and return if @usuario.email == 'admin' or @usuario.email == 'guest'

    @usuario.delete
    redirect_to admin_usuarios_path, :notice => 'User deleted'
  end

  private
  def restricted
    render :status => 403 if @logged_as.email != 'admin'

    @tab = :users
  end
end
