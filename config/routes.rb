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
  get 'explore',  to: 'ikat#explore'

  resources :products, only: [:new, :create]

  scope '/:store_domain', constraints: { store_domain: /[a-zA-Z0-9][a-zA-Z0-9-_]{0,61}[a-zA-Z0-9]{0,1}\.([a-zA-Z]{1,6}|[a-zA-Z0-9]{1,30}\.[a-zA-Z]{2,3})/ } do
    get '/', to: 'stores#show', as: 'store'

    post '/follow', to: 'stores#follow', as: 'follow_store'
    patch '/unfollow', to: 'stores#unfollow', as: 'unfollow_store'

    get '/:product_slug', to: 'products#show', as: 'product'
  end

  scope '/:username' do
    get '/', to: 'users#show', as: 'profile'

    get '/wants', to: 'wants#show', as: 'wants'
    get '/owns', to: 'owns#show', as: 'owns'
    
    get '/collections', to: 'collections#index', as: 'collections'
    get '/collections/:collection_slug', to: 'collections#show', as: 'collection'

    post '/follow', to: 'users#follow', as: 'follow_user'
    patch '/unfollow', to: 'users#unfollow', as: 'unfollow_user'
  end

  root 'ikat#index'
end
