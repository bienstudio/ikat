Rails.application.routes.draw do
  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'

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
  get 'explore(/:categories)', to: 'ikat#explore', as: 'explore', constraints: { categories: /.*/ }

  get 'bookmarklet/:url', to: 'ikat#bookmarklet', constraints: { url: /.*/ }

  resources :products, only: [:new, :create] do
    post 'flux', to: 'products#flux', as: 'flux'
  end

  resources :collections, except: [:index, :show]

  scope '/:store_domain', constraints: { store_domain: /[a-zA-Z0-9][a-zA-Z0-9]{0,61}[a-zA-Z0-9]{0,1}\.([a-zA-Z]{1,6}|[a-zA-Z0-9]{1,30}\.[a-zA-Z]{2,3})/ } do
    get '/', to: 'stores#show', as: 'store'

    post '/flux', to: 'stores#flux', as: 'store_flux'
    post '/follow', to: 'stores#follow', as: 'follow_store'
    patch '/unfollow', to: 'stores#unfollow', as: 'unfollow_store'

    get '/followers', to: 'stores#followers', as: 'store_followers'

    get '/:product_slug', to: 'products#show', as: 'product'

    get '/:product_slug/buy', to: 'products#buy', as: 'product_buy'
  end

  scope '/:username' do
    get '/', to: 'users#show', as: 'profile'

    get '/wants', to: 'wants#show', as: 'user_wants'

    get '/collections', to: 'collections#index', as: 'user_collections'
    get '/collections/:collection_slug', to: 'collections#show', as: 'user_collection'

    post '/flux', to: 'users#flux', as: 'user_flux'
    post '/follow', to: 'users#follow', as: 'follow_user'
    patch '/unfollow', to: 'users#unfollow', as: 'unfollow_user'

    get '/followers', to: 'users#followers', as: 'followers'
    get '/following', to: 'users#following', as: 'following'
  end

  root 'ikat#index'
end
