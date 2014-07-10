Rails.application.routes.draw do
  root 'welcome#index'
  get '/register', to: 'users#new', as: 'new_registration'
  resources :users
end
