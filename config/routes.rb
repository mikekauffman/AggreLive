Rails.application.routes.draw do
  root 'welcome#index'
  get '/register', to: 'users#new', as: 'new_registration'
  resources :users
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/login', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create'
end
