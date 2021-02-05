class MenusController < ApplicationController
  def index
    current_user
    render "index"
  end

  def create
    if !ensure_owner
      return
    end
    name = params[:name]
    new_menu = Menu.new(name: name, active: false)
    if new_menu.save
      redirect_to "/menus"
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
      redirect_to "/menus"
    end
  end

  def update
    id = params[:id]
    active = params[:active]
    menu = Menu.find(id)
    menu.active = active
    if not menu.save
      flash[:error] = menu.errors.full_messages.join(", ")
    end
    redirect_to "/menus"
  end

  def destroy
    ensure_owner
    id = params[:id]
    MenuItem.where(menu_id: id).delete_all
    menu = Menu.find(id).destroy
    redirect_to "/menus"
  end
end
