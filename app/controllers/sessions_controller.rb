class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def destroy
    log_user_out
    redirect_to root_path
  end

  def create
    user = User.find_by(email: params[:user][:email].downcase)
    if user.present? && user.authenticate(params[:user][:password])
      log_user_in(user)
      redirect_to root_path
    else
      @user = User.new
      flash[:login_error] = "Invalid email or password"
      render 'sessions/new'
    end
  end

end