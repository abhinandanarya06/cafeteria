class MenusController < ApplicationController
  def new
    render "menus/new"
  end

  def create
    name = params[:name]
    new_menu = Menu.new(name: name)
    if new_menu.save
      redirect_to "/menus"
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
      redirect_to new_menu_path
    end
  end

  def destroy
    id = params[:id]
    MenuItem.where(menu_id: id).delete_all
    Menu.find(id).destroy
    redirect_to "/menus"
  end
end
