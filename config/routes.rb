Rails.application.routes.draw do
  root('static#home')

  get '/menu', to: 'static#menu'
  get '/about_us', to: 'static#about_us'
  get '/profile', to: 'users#profile'
  get '/profile/:id/edit', to: 'users#edit', as: 'profile_edit'
  patch '/profile/:id', to: 'users#update', as: 'profile_update'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create', as: 'post_signup'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: "sessions#logout"
  
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  
  get '/search', to: 'products#search', as: 'search'

  resources :products do 
      post '/add_to_cart', to: 'cart_products#add_to_cart', as: 'add_to_cart'
      post '/add_to_cart_page', to: 'cart_products#cart_pg_add_product', as: 'cart_pg_add_product'
      post '/delete_cart_product', to: 'cart_products#delete_cart_product', as: 'delete_cart_product'
      get '/cart_products/:id', to: "cart_products#show", as: 'cart_product'
      delete 'cart_products/:id', to: "cart_products#destroy"
    
  end
 
  resources :users do 
    get '/my-products', to: 'products#index'
  end
  
  resources :carts do 
    resources :cart_products
  end
  
  resources :cart_products
 

end
