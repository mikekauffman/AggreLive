Rails.application.routes.draw do
  root 'welcome#index'
  get '/register', to: 'users#new', as: 'new_registration'
  resources :users
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/login', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create'
  post '/search', to: 'searches#create', as: 'new_search'
  get '/search/:term', to: 'searches#show', as: 'search'
  get '/users/:id/events/:event_id', to: 'events#create'
  get '/users/:id/events/:event_id/remove', to: 'events#destroy'
end
