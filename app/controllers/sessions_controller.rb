class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        activate_yet
      else
        activate_success
      end
    else
      flash.now[:danger] = t ".session_mesage"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def activate_yet
    log_in @user
    remember_me
    remember @user
  end

  def activate_success
    message  = t ".email_msg1"
    message += t ".email_msg2"
    flash[:warning] = message
    redirect_to root_url
  end

  def remember_me
    params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
    redirect_back_or @user
  end
end
