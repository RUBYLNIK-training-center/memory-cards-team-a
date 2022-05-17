Rails.application.routes.draw do
  root 'welcome#index', as: 'home'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :cards
end
