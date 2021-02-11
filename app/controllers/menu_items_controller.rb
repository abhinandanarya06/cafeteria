class MenuItemsController < ApplicationController
  before_action :ensure_owner

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
    if params[:image]
      new_menu_item.image = params[:image]
    end
    if !new_menu_item.save
      flash[:error] = new_menu_item.errors.full_messages.join(", ")
    end
    redirect_back fallback_location: "/"
  end

  def update
    id = params[:id]
    item = MenuItem.find(id)
    item.name = params[:name]
    item.description = params[:description]
    item.price = params[:price].to_f
    if params[:image]
      item.image = params[:image]
    end
    if !item.save
      flash[:error] = item.errors.full_messages
    end
    redirect_back fallback_location: "/"
  end

  def destroy
    id = params[:id]
    MenuItem.find(id).destroy
    redirect_back fallback_location: "/"
  end
end
