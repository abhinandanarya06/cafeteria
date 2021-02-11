class OrdersController < ApplicationController
  before_action :ensure_owner_or_clerk, only: [:update]

  def create
    user_id = current_user.id
    new_order = Order.create_from_cart(user_id)
    if new_order
      redirect_to "/orders"
    else
      flash[:error] = new_order.errors.full_messages.join(", ")
      redirect_to new_order_path
    end
  end

  def update
    id = params[:id]
    begin
      datetime = DateTime.parse(params[:datetime])
    rescue
      datetime = DateTime.now()
    end
    order = Order.find(id)
    order.delivered_at = datetime.to_s(:short)
    if !order.save
      flash[:error] = order.errors.full_messages.join(", ")
    else
      flash[:message] = "Marked the order as delivered on #{datetime.to_s(:short)}"
    end
    redirect_back fallback_location: "/reports"
  end
end
