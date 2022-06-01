Rails.application.routes.draw do
  scope "(:locale)",locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    root 'welcome#index'
    resources :boards do
      patch '/cards/:id', to: 'ajax#change_confidence_level'
      resources :cards
      
      get '/learning', to: 'cards#learn'
      
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
end
