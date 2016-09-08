Rails.application.routes.draw do
  resources :users
  resources :posts
  resources :comments, only: [:new, :create]

  root 'application#home'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', as: 'logout'

  get '/signup', to: 'registrations#new',  as: 'signup'

  post '/signup', to: 'registrations#create'

  get '/users/:id/follow', to: 'followships#follow', as: 'follow'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
