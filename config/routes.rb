Rails.application.routes.draw do

  devise_for :users

  resources :groups, only: [:index, :show]
  resource :personal_balance, only: :show
  resources :personal_records, only: [:create, :update, :destroy]
  resources :records, only: [:create, :update, :destroy]

  root 'personal_balances#show'

end