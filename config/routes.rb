Rails.application.routes.draw do
  post 'mailgun/click'

  post 'mailgun/bounce'

  get 'authentication/new'

  get '/signup', to: 'users#new'

  get '/home', to: 'static_pages#home'

  get '/help', to: 'static_pages#help'

  get  '/login',   to: 'authentication#new'

  post '/login',   to: 'authentication#create'

  delete '/logout',  to: 'authentication#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#home'

  resources :users

  resources :account_activations, only: [:edit]
end
