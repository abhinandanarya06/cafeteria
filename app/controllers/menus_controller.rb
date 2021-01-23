class MenusController < ApplicationController
  skip_before_action :ensure_user_logged_in

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
end
