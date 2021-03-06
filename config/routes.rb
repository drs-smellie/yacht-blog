Blog::Application.routes.draw do
  
  get "sign_up" => "users#new", :as => "sign_up"
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
 
  resources :users
  resources :sessions

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  
  root 'welcome#index'
end
