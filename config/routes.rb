Rails.application.routes.draw do

  devise_for :users
  resources :records, only: [:index, :create, :update, :destroy]

  root 'records#index'

end