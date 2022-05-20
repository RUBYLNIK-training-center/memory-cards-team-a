Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'welcome#index'
  resources :boards do
    resources :cards
  end
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get '/instructions', to: 'instructions#manual'
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
    end
end
