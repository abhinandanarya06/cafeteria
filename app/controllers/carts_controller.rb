class CartsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    render "index"
  end

  def create
    user_id = params[:user_id]
    menu_item_id = params[:menu_item_id]
    quantity = params[:quantity]
    success = Cart.addItem(
      user_id: user_id,
      menu_item_id: menu_item_id,
      quantity: quantity,
    )
    if !success
      flash[:error] = success.errors.full_messages
    end
    redirect_back fallback_location: "/"
  end

  def update
    quantity = params[:quantity]
    id = params[:id]
    cart_item = Cart.find(id)
    cart_item.quantity = quantity
    if !cart_item.save
      flash[:error] = cart_item.errors.full_messages
    end
    redirect_back fallback_location: "/"
  end

  def destroy
    id = params[:id]
    Cart.find(id).destroy
    redirect_back fallback_location: "/"
  end
end
