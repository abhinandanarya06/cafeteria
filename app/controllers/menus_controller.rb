class MenusController < ApplicationController
  before_action :ensure_owner, only: [:create, :update, :destroy]

  def index
    render "index"
  end

  def create
    name = params[:name]
    new_menu = Menu.new(name: name, active: false)
    if !new_menu.save
      flash[:error] = new_menu.errors.full_messages.join(", ")
    end
    redirect_back fallback_location: "/menus"
  end

  def update
    id = params[:id]
    active = params[:active]
    menu = Menu.find(id)
    menu.active = active
    if params[:name]
      menu.name = params[:name]
    end
    if not menu.save
      flash[:error] = menu.errors.full_messages.join(", ")
    end
    redirect_back fallback_location: "/menus"
  end

  def destroy
    id = params[:id]
    MenuItem.where(menu_id: id).delete_all
    menu = Menu.find(id).destroy
    redirect_back fallback_location: "/menus"
  end
end
