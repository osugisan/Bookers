Rails.application.routes.draw do
  get 'home/top'
  get 'home/about'
  root 'home#top'
  devise_for :users
  resources :book
  resources :users, only: [:show, :edit, :update, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
