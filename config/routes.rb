ProDigitalPhotos::Application.routes.draw do
  resources :pages
  get '*slug' => 'pages#show', :as => :page
end