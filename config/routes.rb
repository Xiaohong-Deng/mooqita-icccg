Rails.application.routes.draw do
  get 'stages/show'

  devise_for :users

  root 'static_pages#home'
  get '/games/waiting-room', to: 'game_waiting_rooms#index'
  resources :games, only: [:show, :update] do
    member do
      get :judge # send a judge form to judge to let him choose the right answer
    end
  end
  resources :questions, only: [:create]
  resources :answers, only: [:create, :update]

  mount ActionCable.server => '/cable'
end
