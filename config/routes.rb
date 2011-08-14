ProDigitalPhotos::Application.routes.draw do
  resources :pages, :except => [:show] do
    get 'sort', :on => :collection, :as => :sort
    get 'hidden', :on => :collection, :as => :hidden
    get 'restore', :on => :member, :as => :restore
  end

  # login
  get 'login' => 'sessions#new', :as => 'login'
  post 'login' => 'sessions#create', :as => 'login'
  delete 'logout' => 'sessions#destroy', :as => 'logout'

  # sitemap(s)
  get 'sitemap' => 'sitemaps#index', :as => 'sitemaps'
  resources :sitemaps, :only => [:show]

  # match all our slugs
  get '*id' => 'pages#show', :as => :slug

  # temp
  root :to => redirect('/home')
end