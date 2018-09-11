Rails.application.routes.draw do

  apipie
  resources :users, only: [:create] do
    member do
      put 'contact'
    end
  end
  resources :profiles, only: [:index, :show, :update, :create] do
    member do
      put 'approve'
    end
  end
  resources :profiles, only: [:create]
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  root to: redirect('/x')
end
