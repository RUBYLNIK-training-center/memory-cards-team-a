Rails.application.routes.draw do
  root 'welcome#index'
  resources :boards
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :cards
  get '/instructions', to: 'instructions#manual'
end
