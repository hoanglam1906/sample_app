class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate(params[:session][:password])
      log_in @user
      remember_me
      remember @user
    else
      flash.now[:danger] = t ".session_mesage"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def remember_me
    params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
    redirect_back_or @user
  end
end
