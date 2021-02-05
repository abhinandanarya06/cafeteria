Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "home#index"
  resources "users"
  resources "orders"
  resources "menus"
  resources "menu_items"
  resources "carts"

  get "/signin" => "sessions#new", as: :new_signin
  post "/signin" => "sessions#create", as: :signin
  delete "/signout" => "sessions#destroy", as: :destroy_session

  get "/reports", to: "reports#index"
end
