include Recaptcha::Adapters::ViewMethods
include Recaptcha::Adapters::ControllerMethods

class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in
  before_action :ensure_owner, only: [:index, :destroy]
  before_action :ensure_user_logged_in, only: [:edit, :update]

  def index
    render "users/index"
  end

  def new
    render "users/new"
  end

  def create
    return if !verify_recaptcha?("REGISTER")
    name = params[:name]
    role = params[:role]
    if role != "Customer" && !is_owner?
      return
    end
    email = params[:email]
    password = params[:password]
    new_user = User.new(
      name: name,
      role: role,
      email: email.downcase,
      password: password,
    )
    if new_user.save
      if current_user && is_owner?
        redirect_back fallback_location: "/"
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

  def edit
    render "edit"
  end

  def update
    id = params[:id]
    user = User.find(id)
    if !is_owner? && user.id != current_user.id
      flash[:error] = "You are not allowed to update other's profile"
      redirect_back fallback_location: "/"
      return
    end
    if is_owner?
      # Only owner can update user's role
      role = params[:role]
      user.role = role.nil? ? user.role : role
    end
    name = params[:name]
    email = params[:email]
    password = params[:password]
    user.name = name.nil? ? user.name : name
    user.email = email.nil? ? user.email : email
    user.password = password.nil? ? user.password : password
    if !user.save
      flash[:error] = user.errors.full_messages
    end
    redirect_back fallback_location: "/"
  end

  def destroy
    user_id = params[:id]
    User.find(user_id).destroy
    order = Order.find_by(user_id: user_id)
    if order
      order.destroy
    end
    redirect_back fallback_location: "/"
  end
end
