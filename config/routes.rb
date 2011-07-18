ProDigitalPhotos::Application.routes.draw do
  resources :pages, :except => [:show]
  
  # login
  get 'login' => 'sessions#new', :as => 'login'
  post 'login' => 'sessions#create', :as => 'login'
  delete 'logout' => 'sessions#destroy', :as => 'logout'
  
  # sitemap(s)
  resources :sitemaps, :only => [:show, :index]

  # match all our slugs
  get '*slug' => 'pages#show', :as => :page
  
  # temp
  root :to => redirect('/pages')
end