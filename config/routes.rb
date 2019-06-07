Rails.application.routes.draw do
 
  devise_for :admins
  get 'admins' => 'admins#index'
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :users do
    resources :folders
  end

  resources :folders do
  	resources :items
  end
   
  root 'static_pages#home'
  get '/home', to: 'static_pages#home'

  resources :sample_folders do
    resources :sample_uploads
  end

  resources :get_links

  namespace :api, defaults: { format:'json' } do
    namespace :v1 do
      post 'auth' => 'authentications#authorize'
      resources :users, param: :name, only: [:index, :show] do 
        resources :folders
      end
      resources :box_uploads
    end
  end
  
end
