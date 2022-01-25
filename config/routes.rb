Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      
      post 'auth/login', to: 'authentication#login'
      post 'auth/refresh', to: 'authentication#refresh'
      
      resources :users, only: %i[show index update create] do
      
      
      end
      
    end
  end
    
    
  
  
  get '/apple-app-site-association' => 'universal_links#apple_site_assoc'
  get '/.well-known/apple-app-site-association' => 'universal_links#apple_site_assoc'
  
  
end
