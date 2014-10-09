require 'sidekiq/web'

Rails.application.routes.draw do

  # GET /admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # GET /sidekiq
  mount Sidekiq::Web => '/sidekiq'

  # GET /users/sign_in
  # POST /users/sign_in
  # DELETE /users/sign_out
  # POST /users/password
  # GET /users/password/new
  # GET /users/password/edit
  # PATCH /users/password
  # PUT /users/password
  # GET /users/cancel
  # POST /users
  # GET /users/sign_up
  # GET /users/edit
  # PATCH /users
  # PUT /users
  # DELETE /users
  devise_for :users

  devise_scope :user do
    # GET /login
    get 'login',    to: 'devise/sessions#new'

    # GET /logout
    get 'logout',   to: 'devise/sessions#destroy'

    # GET /join
    get 'join',     to: 'devise/registrations#new'

    # GET /settings
    get 'settings', to: 'devise/registrations#edit'
  end

  # GET /features
  get 'features', to: 'ikat#features'

  # GET /about
  get 'about',    to: 'ikat#about'

  # GET /blog
  get 'blog',     to: 'ikat#blog'

  # GET /support
  get 'support',  to: 'ikat#support'

  # GET /ui
  get 'ui',       to: 'ikat#ui'

  # GET /explore(/:categories)
  # get 'explore(/:categories)', to: 'ikat#explore', as: 'explore', constraints: { categories: /.*/ }

  # GET /explore(/:categories)
  get 'explore(/:categories)', to: 'explore#show', as: 'explore', constraints: { categories: /.*/ }

  # GET /bookmarklet/:url
  get 'bookmarklet/:url', to: 'bookmarklet#show', constraints: { url: /.*/ }

  # GET /products/new
  # POST /products
  resources :products, only: [:new, :create] do
    # POST /products/:product_id/flux
    post 'flux', to: 'products#flux', as: 'flux'
  end

  # POST /collections
  # GET /collections/new
  # PATCH /collections/:id
  # PUT /collections/:id
  # DELETE /collections/:id
  resources :collections, except: [:index, :show, :edit]

  scope '/:store_domain', constraints: { store_domain: /([a-z0-9]+\.)*[a-z0-9]+\.[a-z]{2,}+/ } do
    # GET /:store_domain
    get '/', to: 'stores#show', as: 'store'

    # GET /:store_domain/flux
    post '/flux', to: 'stores#flux', as: 'store_flux'

    # GET /:store_domain/followers
    get '/followers', to: 'stores#followers', as: 'store_followers'

    # GET /:store_domain/:product_slug
    get '/:product_slug', to: 'products#show', as: 'product'

    # GET /:store_domain/:product_slug/buy
    get '/:product_slug/buy', to: 'products#buy', as: 'product_buy'
  end

  scope '/:username' do
    # GET /:username
    get '/', to: 'users#show', as: 'profile'

    # GET /:username/wants
    get '/wants', to: 'wants#show', as: 'user_wants'

    # GET /:username/collections
    get '/collections', to: 'collections#index', as: 'user_collections'

    # GET /:username/collections/:collection_slug
    get '/collections/:collection_slug', to: 'collections#show', as: 'user_collection'

    # POST /:username/flux
    post '/flux', to: 'users#flux', as: 'user_flux'

    # GET /:username/followers
    get '/followers', to: 'users#followers', as: 'followers'

    # GET /:username/following
    get '/following', to: 'users#following', as: 'following'
  end

  # GET /
  root 'ikat#index'
end
