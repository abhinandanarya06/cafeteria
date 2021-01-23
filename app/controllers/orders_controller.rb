class OrdersController < ApplicationController
  def new
    render "orders/new"
  end

  def create
    user_id = @current_user.id
    items_ids = params[:ids].split
    items_quantities = params[:quantities].split
    new_order = Order.new(
      date: Date.today,
      user_id: user_id,
    )
    items_ids.each.with_index { |id, i|
      OrderItem.create(
        order_id: new_order.id,
        menu_item_id: id,
        menu_item_name: MenuItem.find(id).name,
        menu_item_price: items_quantities[i] * MenuItem.find(id).price,
      )
      Cart.find_by(menu_item_id: id).destroy
    }
    if new_order.save
      redirect_to "/orders"
    else
      flash[:error] = new_order.errors.full_messages.join(", ")
      redirect_to new_order_path
    end
  end
end
