Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#home'

  get '/game', to: 'games#game'

  mount ActionCable.server => '/cable'
end
