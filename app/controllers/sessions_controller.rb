include Recaptcha::Adapters::ViewMethods
include Recaptcha::Adapters::ControllerMethods

class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "new"
  end

  def create
    return if !verify_recaptcha?("LOGIN")
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      current_user
      flash[:message] = "You are successfully logged in"
      redirect_to "/"
    else
      flash[:error] = "Invalid credentials"
      redirect_to new_signin_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
