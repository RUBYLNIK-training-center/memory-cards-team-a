Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get '/board', to: 'board#index'
  get '/contact', to: 'board#contact'
  get '/card', to: 'board#card'
  root 'board#index'
  get 'persons/profile', as: 'user_root'

end
