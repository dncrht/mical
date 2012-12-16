class Admin::UsersController < AdminController
  before_filter :restricted, :set_tab

  def index
    @users = User.order('email')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to admin_users_path, :notice => 'User created'
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to admin_users_path, :notice => 'User updated'
    else
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
  end
  
  def set_tab
    @tab = :users
  end

end
