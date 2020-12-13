Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :sessions
  delete "/logout" => "sessions#logout", :as => "logout"

end
