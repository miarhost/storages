Rails.application.routes.draw do
 
  devise_for :users 
  resources :users do
   resources :folders
  end
  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
end
