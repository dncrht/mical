class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params[:email])

    if valid_login?(@user)
      log_in @user.id
      redirect_to root_path
    else
      @user = User.new
      flash.now[:alert] = "We couldn't log you in. Please enter a valid email and password, or reset your password."
      render partial: 'form'
    end
  end

  def destroy
    log_out

    redirect_to root_path, status: :see_other
  end

  private

  def valid_login?(user)
    return false unless user
    return false if user.password_digest.nil?

    user.authenticate(user_params[:password]).present?
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
