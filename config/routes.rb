Rails.application.routes.draw do
  resources :carts
  resources :sessions
  resources :cart_products
  resources :statics
  resources :products
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
