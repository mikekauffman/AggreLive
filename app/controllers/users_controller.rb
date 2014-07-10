class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      log_user_in(user)
      redirect_to root_path
    else
      @user = user
      render 'users/new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email.downcase, :password, :password_confirmation)
  end
end