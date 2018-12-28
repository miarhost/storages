Rails.application.routes.draw do
 
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  resources :users do
    resources :folders
  end

  resources :folders do
  	 resources :items
  end
   
  root 'static_pages#home'
  get '/home', to: 'static_pages#home'

end
