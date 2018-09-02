Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  get '/x' => 'application#angular'

  root to: redirect('/x')
end
