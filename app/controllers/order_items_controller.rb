class OrderItemsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "order_items/new"
  end

  def create
    order = params[:order]
    order_id = order.split[0].to_i
    menu_item_name = params[:item].split[1]
    menu_item = MenuItem.find_by(name: menu_item_name)

    new_order_item = OrderItem.new(
      order_id: order_id,
      menu_item_id: menu_item.id,
      menu_item_name: menu_item_name,
      menu_item_price: menu_item.price,
    )
    if new_order_item.save
      redirect_to "/order_items"
    else
      flash[:error] = new_order_item.errors.full_messages.join(", ")
      redirect_to new_order_item_path
    end
  end
end
