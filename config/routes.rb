Rails.application.routes.draw do
  get 'stages/show'

  devise_for :users

  root 'static_pages#home'
  get '/games/waiting-room', to: 'game_waiting_rooms#index'
  resources :games, only: [] do
    resources :stages, only: [:show]
  end

  mount ActionCable.server => '/cable'
end
