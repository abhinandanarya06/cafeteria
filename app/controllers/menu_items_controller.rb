class MenuItemsController < ApplicationController
  before_action :ensure_owner

  def new
    render "menu_items/new"
  end

  def create
    menu_id = params[:menu_id]
    name = params[:name]
    description = params[:description]
    price = params[:price]
    new_menu_item = MenuItem.new(
      menu_id: menu_id,
      name: name,
      description: description,
      price: price,
    )
    if new_menu_item.save
      redirect_to "/menus"
    else
      flash[:error] = new_menu_item.errors.full_messages.join(", ")
      redirect_to "/menus"
    end
  end
end
