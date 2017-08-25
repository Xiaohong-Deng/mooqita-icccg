Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#home'
  get '/games/waiting-room', to: 'games#waiting_room'
  resources :games, only: [:show]

  mount ActionCable.server => '/cable'
end
