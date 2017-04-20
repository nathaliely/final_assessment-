Rails.application.routes.draw do
  get 'welcome/index'

  get '/search', to: 'items#search', as: 'search'

  resources :users
  resources :items do
    collection do
      get :search
    end
  end
  resources :users, controller: "users", only: :show

  root'sessions#new'

  get '/users/new', to: 'users#new', as: 'signup'
  get '/sessions/new', to: 'sessions#new', as: 'login'
  post '/sessions/new', to: 'sessions#create'
  get '/sessions/delete', to: 'sessions#destroy', as: 'logout'

  get 'auth/:provider/callback', to: 'sessions#create_from_omniauth', as: "omni_auth"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
