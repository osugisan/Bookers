Rails.application.routes.draw do
  get 'chats/show'
  get 'home/about'
  root 'home#top'
  devise_for :users
  resources :users, only: [:show, :edit, :update, :index] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  get "search" => "searches#search"

  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
