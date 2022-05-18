Rails.application.routes.draw do
  root 'welcome#index'
  resources :boards do
    resources :cards
  end
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
