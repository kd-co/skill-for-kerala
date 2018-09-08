Rails.application.routes.draw do

  apipie
  resources :users, only: [:create]
  resources :profiles, only: [:index, :show, :update, :create]
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  root to: redirect('/x')
end
