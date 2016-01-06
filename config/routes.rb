Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # devise_for :users, controllers: { registrations: 'users/registrations'}
  devise_for :users

  resource :dashboard, only: :show, controller: 'dashboard'
  resources :groups, only: [:create, :show]
  resource :locale, only: :update
  resources :personal_balances, only: [:create, :show]
  resources :personal_records, only: [:create, :update, :destroy]
  resources :records, only: [:create, :update, :destroy]

  root 'dashboard#show'

end
