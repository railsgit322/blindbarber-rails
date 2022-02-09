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
      resources :user, only: [:index]

      resources :subscriptions do
        collection do
          get "selling_plan_groups"
          post "product_variant_join_selling_plan_groups"
          post "product_variant_leave_selling_plan_groups"
          post "product_join_selling_plan_groups"
          post "product_leave_selling_plan_groups"
        end
      end
      get 'shopify-token', to: 'subscriptions#generate_token'
      resources :users, only: %i[index update create] do
        resources :haircuts, only: [:index, :create, :destroy, :update]
        resources :addresses, only: [:index, :create, :destroy, :update, :show] do
          member do
            post '/default', to: "addresses#default"
          end
        end

        collection do
          post :forgot_password
          post :password_reset
        end
        
      end
    end
  end

  get '/apple-app-site-association' => 'universal_links#apple_site_assoc'
  get '/.well-known/apple-app-site-association' => 'universal_links#apple_site_assoc'
end
