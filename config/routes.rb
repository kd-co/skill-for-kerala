Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  apipie
  resources :users, only: [:create] do
    member do
      put 'contact'
    end
  end
  resources :profiles, only: %i[index show update create] do
    member do
      put 'approve'
    end
  end
  resources :projects, only: %i[create index]
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  root to: redirect('/x')
end
