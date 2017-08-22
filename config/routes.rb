Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#home'

  resources :games, only: [:create, :show]

  mount ActionCable.server => '/cable'
end
