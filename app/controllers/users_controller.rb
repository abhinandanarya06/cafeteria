class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "users/new"
  end

  def create
    name = params[:name]
    role = params[:role]
    email = params[:email]
    password = params[:password]
    new_user = User.new(
      name: name,
      role: role,
      email: email,
      password: password,
    )
    if new_user.save
      session[:current_user_id] = new_user.id
      @current_user = current_user
      redirect_to "/"
    else
      flash[:error] = new_user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end
end
