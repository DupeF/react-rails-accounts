Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations'}

  resources :groups, only: [:index, :show]
  resource :locale, only: :update
  resource :personal_balance, only: :show
  resources :personal_records, only: [:create, :update, :destroy]
  resources :records, only: [:create, :update, :destroy]

  root 'personal_balances#show'

end
