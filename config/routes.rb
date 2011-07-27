ProDigitalPhotos::Application.routes.draw do
  resources :pages, :except => [:show] do
    get 'sort', :on => :collection, :as => :sort
  end
  
  # login
  get 'login' => 'sessions#new', :as => 'login'
  post 'login' => 'sessions#create', :as => 'login'
  delete 'logout' => 'sessions#destroy', :as => 'logout'
  
  # sitemap(s)
  resources :sitemaps, :only => [:show, :index]

  # match all our slugs
  get '*id' => 'pages#show', :as => :slug
  
  # temp
  root :to => redirect('/pages')
end