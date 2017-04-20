Rails.application.routes.draw do
  get 'welcome/index'

  get '/search', to: 'listings#search', as: 'search'

  resources :users
  resources :items
  resources :users, controller: "users", only: :show
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  root'sessions#new'

  get '/users/new', to: 'users#new', as: 'signup'
  get '/sessions/new', to: 'sessions#new', as: 'login'
  post '/sessions/new', to: 'sessions#create'
  get '/sessions/delete', to: 'sessions#destroy', as: 'logout'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
