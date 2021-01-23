class OrdersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "orders/new"
  end

  def create
    email = params[:email]
    user = User.find_by(email: email)
    new_order = Order.new(
      date: Date.today,
      user_id: user.id,
    )
    if new_order.save
      redirect_to "/orders"
    else
      flash[:error] = new_order.errors.full_messages.join(", ")
      redirect_to new_order_path
    end
  end
end
