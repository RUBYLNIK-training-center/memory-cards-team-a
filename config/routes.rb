# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => 'sidekiq'
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'omniauth'}
  scope "(:locale)",locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    root 'welcome#index'
    resources :boards do
      
      resources :cards
      get '/learning', to: 'cards#learn'
    end
    devise_for :users, controllers: {registrations: 'registrations'},skip: [:omniauth_callbacks]
    devise_scope :user do
      get '/users/sign_out' => 'devise/sessions#destroy'
    end
    get '/instructions', to: 'instructions#manual'
    get '/404', to: "errors#not_found"
    get '/422', to: "errors#unacceptable"
    get '/500', to: "errors#internal_error"
    resource :user, only: [:edit] do
      collection do
        patch 'update_password'
        put 'update_account_type'
      end
    end
    patch '/cards/:id', to: 'ajax#change_confidence_level'
    put '/cards/:id', to: 'ajax#update_card_throw_modal'
  end
  resources :imports
end
