class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :ensure_user_logged_in
  helper_method :is_owner?, :is_customer?, :is_clerk?, :current_user

  def is_owner?
    current_user && current_user.role == "Owner"
  end

  def is_clerk?
    current_user && current_user.role == "Billing Clerk"
  end

  def is_customer?
    current_user && current_user.role == "Customer"
  end

  def ensure_user_logged_in
    unless current_user
      redirect_to "/"
    end
  end

  def ensure_owner
    unless current_user && is_owner?
      flash[:error] = "Access Denied!. You are not owner"
      redirect_to "/"
    end
  end

  def ensure_owner_or_clerk
    unless is_owner? || is_clerk?
      flash[:error] = "Access Denied!. You are not owner or clerk"
      redirect_to "/"
    end
  end

  def ensure_customer
    unless is_customer?
      flash[:error] = "Access Denied!. You are not customer"
      redirect_to "/"
    end
  end

  def current_user
    return @current_user if @current_user
    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    else
      nil
    end
  end
end
