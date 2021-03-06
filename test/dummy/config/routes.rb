Rails.application.routes.draw do

  get "/articles" => 'articles#index'

  #resources :products
  get "/products" => 'products#index'


  #resources :people
  get "/people" => 'people#index'
  get "/search_people" => 'people#search_only_index'
  get "/sort_people" => 'people#sort_only_index'
  
  get "/vehicles" => 'vehicles#index'
  get "/search_vehicles" => 'vehicles#search_only_index'
  get "/sort_vehicles" => 'vehicles#sort_only_index'
  get "/unsearchables" => 'unsearchables#index'
  get "/items" => "items#index"

  scope module: "admin" do
    get "members" => 'members#index_explicit_setup', as: 'admin_members'
  end

  
  # get "/people" => "people#index"
  # get "/person/:id" => ""
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
