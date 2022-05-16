Rails.application.routes.draw do
  devise_for :users
  # resources :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get '/board', to: 'board#index'
  get '/contact', to: 'board#contact'
  root 'board#index'
  # get 'persons/profile', as: 'user_root'

  resources :cards
end
