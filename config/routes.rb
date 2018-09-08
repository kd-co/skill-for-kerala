Rails.application.routes.draw do

  resources :users, only: [:create]
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  root to: redirect('/x')
end
