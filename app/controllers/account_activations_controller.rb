class AccountActivationsController < ApplicationController
  before_action :find_user
  attr_reader :user
  def edit
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      activate_now
      flash[:success] = t ".activate_success"
      redirect_to user

    else
      flash[:danger] = t ".invalid_link"
      redirect_to root_url
    end
  end

  def activate_now
    user.update_attribute(:activated, true)
    user.update_attribute(:activated_at, Time.zone.now)
    user.activate
    log_in user
  end

  def find_user
    @user = User.find_by email: params[:email]
  end
end
