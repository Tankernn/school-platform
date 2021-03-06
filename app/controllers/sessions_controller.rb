class SessionsController < ApplicationController
  def new
    redirect_to home_path if logged_in?
  end

  def create
    @user = User.find_by(login: params[:session][:login].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or home_url
    else
      flash.now[:danger] = 'Invalid login/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_url
  end
end
