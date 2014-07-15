Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'login',    to: 'devise/sessions#new'
    get 'logout',   to: 'devise/sessions#destroy'
    get 'join',     to: 'devise/registrations#new'
    get 'settings', to: 'devise/registrations#edit'
  end

  get 'features', to: 'ikat#features'
  get 'about',    to: 'ikat#about'
  get 'blog',     to: 'ikat#blog'
  get 'support',  to: 'ikat#support'

  # resources :stores

  resources :products, only: [:new, :create]

  # get '/:store_domain' , to: 'stores#show', as: 'store', constraints: { store_domain: /[a-zA-Z0-9][a-zA-Z0-9-_]{0,61}[a-zA-Z0-9]{0,1}\.([a-zA-Z]{1,6}|[a-zA-Z0-9-]{1,30}\.[a-zA-Z]{2,3})/ }
  # get '/:store_domain/:product_slug', to: 'products#show', as: 'product', constraints: { store_domain: /[a-zA-Z0-9][a-zA-Z0-9-_]{0,61}[a-zA-Z0-9]{0,1}\.([a-zA-Z]{1,6}|[a-zA-Z0-9-]{1,30}\.[a-zA-Z]{2,3})/ }

  scope '/:store_domain', constraints: { store_domain: /[a-zA-Z0-9][a-zA-Z0-9-_]{0,61}[a-zA-Z0-9]{0,1}\.([a-zA-Z]{1,6}|[a-zA-Z0-9-]{1,30}\.[a-zA-Z]{2,3})/ } do
    get '/', to: 'stores#show', as: 'store'
    get '/:product_slug', to: 'products#show', as: 'product'
  end

  get '/:username', to: 'users#show', as: 'profile'

  root 'ikat#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' , to: 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' , to: 'catalog#purchase', as: :purchase

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
