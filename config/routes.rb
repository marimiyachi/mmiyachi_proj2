MmiyachiProj2::Application.routes.draw do
  resources :saveds

  resources :carts

  root to: 'static_pages#home'

  resources :items
  resources :stores
  resources :storekeepers
  resources :sessions

  match '/signup', to: 'storekeepers#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match 'stores/:id/shop' => 'stores#shop', :as => :shop
  match 'storekeepers/:id/cart' => 'storekeepers#cart', :as => :shopping_cart
  match 'storekeepers/:id/basket' => 'items#basket', :as => :basket
  match 'storekeepers/:id/checkout' => 'storekeepers#checkout', :as => :checkout
  match 'storekeepers/:id/fufill' => 'storekeepers#fufill', :as => :fufill

  match 'cartitem/:id/destroy' => 'cart_items#destroy_item', :as => :cart_destroy
  match 'items/:id/destroy' => 'items#destroy', :as => :item_destroy
  match 'cartitem/:id/save' => 'cart_items#save_item', :as => :cart_save
  match 'cartitem/:id/addcart' => 'cart_items#add_cart', :as => :cart_add

  match 'items/search/:id' => 'items#search'

  match 'addcart/:id' => 'storekeepers#addcart'
  match 'addsave/:id' => 'storekeepers#addsave'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
