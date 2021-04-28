Rails.application.routes.draw do
  root('static#home')

  get '/menu', to: 'static#menu'
  get '/about_us', to: 'static#about_us'
  get '/profile', to: 'users#profile'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create', as: 'post_signup'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: "sessions#logout"
  
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  
  get '/search', to: 'products#search', as: 'search'

  resources :products, only: [:index] do 
    get '/products/my-products', to: 'products#vendor_products'
  end

  post '/products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete '/products/delete_cart_item/:id', to: 'products#delete_cart_item', as: 'delete_cart_item'
 
  resources :carts
  
  resources :cart_products
  
  resources :products
end
