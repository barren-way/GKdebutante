Rails.application.routes.draw do

  root 'welcome#index'

  resources :users
  resources :sessions
  get '/logout' => 'sessions#destroy', as: :logout


  namespace :admin do
  	root 'sessions#new'
  	resources :sessions
  	resources :categories
  	resources :products do
      resources :product_images, only: [:index, :create, :destroy, :update]
    end
  end 
end
