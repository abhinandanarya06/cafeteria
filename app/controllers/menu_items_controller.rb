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

  def update
    id = params[:id]
    item = MenuItem.find(id)
    item.name = params[:name]
    item.description = params[:description]
    item.price = params[:price].to_f
    item.image = params[:image]
    if not item.save
      flash[:error] = item.errors.full_messages
    end
    redirect_to "/menus"
  end

  def destroy
    id = params[:id]
    MenuItem.find(id).destroy
    redirect_to "/menus"
  end
end
