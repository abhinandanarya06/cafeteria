class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    @current_user = current_user
    if @current_user.role == "Owner"
      render "users/index"
    else
      render plain: "You are not owner"
    end
  end

  def new
    render "users/new"
  end

  def create
    current_user
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
      if @current_user and @current_user.role == "Owner"
        redirect_to "/users"
      else
        session[:current_user_id] = new_user.id
        @current_user = current_user
        redirect_to "/"
      end
    else
      flash[:error] = new_user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def destroy
    user_id = params[:id]
    User.find(user_id).destroy
    Order.find_by(user_id: user_id).destroy
    redirect_to "/users"
  end
end
