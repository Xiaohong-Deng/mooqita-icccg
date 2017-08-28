Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#home'
  get '/games/waiting-room', to: 'game_waiting_rooms#index'
  resources :games, only: [:show]

  mount ActionCable.server => '/cable'
end
