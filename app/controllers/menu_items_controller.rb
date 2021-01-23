class MenuItemsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "menu_items/new"
  end

  def create
    menu_name = params[:menu_name]
    menu = Menu.find_by(name: menu_name)
    name = params[:name]
    description = params[:description]
    price = params[:price]
    new_menu_item = MenuItem.new(
      menu_id: menu.id,
      name: name,
      description: description,
      price: price,
    )
    if new_menu_item.save
      redirect_to "/menu_items"
    else
      flash[:error] = new_menu_item.errors.full_messages.join(", ")
      redirect_to new_menu_item_path
    end
  end
end
