Rails.application.routes.draw do
  root "posts#index"
  
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
end