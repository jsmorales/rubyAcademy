Rails.application.routes.draw do


=begin
  los recursos anidados o nested resources son recursos que 
  dependen de otro como en este caso los comentarios dependen
  de los articulos.
  para usar uno de esos recursos se escribe:

  resources :modulo do
    resources :modulo_dependiente
  end

=end
  
  devise_for :users
  #get 'welcome/index'

  resources :articles do
    resources :comments, only: [:create, :destroy, :update]
  end

=begin
  resources :articles

  es lo mismo que decir

  verbo "ruta" acción

  get "/articles" index
  post "/articlies" create
  delete "/articles" delete 
  get "/articles/:id" show
  get "/articles/:new" new
  get "/articles/:id/edit" edit
  patch "/articles/:id" update
  put "/articles/:id" update

  y todos los verbos con todo lo que tenga 
  articles.    
=end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

  #recordar que el los verbos de las rutas son get,post,patch,put,delete  

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
