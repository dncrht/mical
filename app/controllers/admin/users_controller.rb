class Admin::UsersController < AdminController
  before_filter :restricted

  def index
    @users = User.order('email')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.password = Digest::MD5.hexdigest(@user.password) unless @user.password.blank?

    if @user.save
      redirect_to admin_users_path, :notice => 'User created'
    else
      @user.password = ''
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])

    redirect_to admin_users_path, :alert => 'User cannot be edited' and return if @user.email == 'guest'

    @user.password = ''
  end

  def update
    @user = User.find(params[:id])

    redirect_to admin_users_path, :alert => 'User cannot be edited' and return if @user.email == 'guest'

    if @user.email == 'admin'
      params[:user] = {:password => params[:user][:password]} #the only field allowing modification is password
    end

    password = params[:user][:password]
    if password.blank? #if password is left blank, we don't update it
      params[:user].delete :password
    else #if password is set, we modify current password
      params[:user][:password] = Digest::MD5.hexdigest(password)
    end

    if @user.update_attributes(params[:user])
      if password.blank? and @user.email == 'admin'
        redirect_to admin_users_path, :notice => 'User not modified'
      else
        redirect_to admin_users_path, :notice => 'User updated'
      end
    else
      @user.clave = ''
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])

    begin
      @user.destroy
      redirect_to admin_users_path, :notice => 'User deleted'
    rescue => e
      redirect_to admin_users_path, :alert => e.message
    end
  end

  private
  
  def restricted
    render :status => 403 unless current_user.is_admin

    @tab = :users
  end
end
