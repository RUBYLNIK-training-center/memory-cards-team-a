Rails.application.routes.draw do
  get '/board', to: 'board#index'
  get '/contact', to: 'board#contact'
  get '/card', to: 'board#card'

end
