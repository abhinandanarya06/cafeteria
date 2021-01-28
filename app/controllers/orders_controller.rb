class OrdersController < ApplicationController
  def new
    render "orders/new"
  end

  def create
    user_id = @current_user.id
    new_order = Order.create(
      date: Date.today,
      user_id: user_id,
    )
    Cart.where(user_id: user_id).each { |item|
      if not MenuItem.where(id: item.menu_item_id).empty?
        OrderItem.create!(
          order_id: new_order.id,
          menu_item_id: item.menu_item_id,
          menu_item_name: item.menu_item_name,
          menu_item_price: item.menu_item_price * item.quantity,
        )
        Cart.find_by(menu_item_id: item.menu_item_id).destroy
      end
    }
    if new_order
      redirect_to "/orders"
    else
      flash[:error] = new_order.errors.full_messages.join(", ")
      redirect_to new_order_path
    end
  end

  def update
    id = params[:id]
    datetime = DateTime.parse(params[:datetime])
    order = Order.find(id)
    order.delivered_at = datetime.to_s(:short)
    if not order.save
      flash[:error] = order.errors.full_messages.join(", ")
    end
    redirect_to "/reports"
  end
end
