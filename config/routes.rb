Rails.application.routes.draw do
 
  devise_for :users 
  resources :users do
   resources :folders
  end
  root 'mains#home'

end
