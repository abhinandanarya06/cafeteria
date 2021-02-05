class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in
  before_action :current_user

  def index
    if !ensure_owner
      return
    end
    render "users/index"
  end

  def new
    render "users/new"
  end

  def create
    name = params[:name]
    role = params[:role]
    if role != "Customer" && !ensure_owner
      return
    end
    email = params[:email]
    password = params[:password]
    new_user = User.new(
      name: name,
      role: role,
      email: email,
      password: password,
    )
    if new_user.save
      if current_user && ensure_owner
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
    order = Order.find_by(user_id: user_id)
    if order
      order.destroy
    end
    redirect_to "/users"
  end
end
