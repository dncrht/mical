class Admin::UsersController < AdminController
  set_tab :users
  access_to { |user| user.is_admin }

  def index
    @users = User.order('email')
  end

  def show
    redirect_to edit_admin_user_path(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

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

    if @user.update_attributes(user_params)
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
    rescue => error
      redirect_to admin_users_path, :alert => error.message
    end
  end

  private

  def user_params
    permitted_params = %i(
      email
      password
      can_download
      can_edit_activity
      can_edit_event
      can_see_legend
      can_see_description
      is_admin
    )

    if params.dig(:user, :password).blank?
      permitted_params.delete :password
    end

    params.require(:user).permit(*permitted_params)
  end
end
