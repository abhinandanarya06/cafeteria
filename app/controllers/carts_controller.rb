class CartsController < ApplicationController
  skip_before_action :ensure_user_logged_in
  before_action :ensure_customer

  def index
    render "index"
  end

  def create
    user_id = params[:user_id]
    menu_item_id = params[:menu_item_id]
    item = MenuItem.find_by_id(menu_item_id)
    quantity = params[:quantity]
    new_item = Cart.new(
      user_id: user_id,
      menu_item_id: menu_item_id,
      menu_item_name: item.name,
      menu_item_price: item.price,
      quantity: quantity,
    )
    if !new_item.save
      flash[:error] = new_item.errors.full_messages
    end
    redirect_to "/menus"
  end

  def update
    quantity = params[:quantity]
    id = params[:id]
    cart_item = Cart.find(id)
    cart_item.quantity = quantity
    if !cart_item.save
      flash[:error] = cart_item.errors.full_messages
    end
    redirect_to "/carts"
  end

  def destroy
    id = params[:id]
    Cart.find(id).destroy
    redirect_to "/carts"
  end
end
