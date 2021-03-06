Rails.application.routes.draw do
  resources :users
  resources :posts do
  	get '/posts', to: 'posts#index'
    post '/up_vote' => 'votes#up_vote', as: :up_vote
    post '/down_vote' => 'votes#down_vote', as: :down_vote

  end
  get '/my-posts', to: 'posts#dashboard', as: 'my_posts'

  resources :comments, only: [:new, :create]

  resources :tags, only: [:index, :show]

  root 'application#home'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', as: 'logout'

  get '/dashboard', to: 'users#dashboard', as: 'dashboard'

  get '/signup', to: 'registrations#new',  as: 'signup'

  post '/signup', to: 'registrations#create'

  post '/users/:id/follow', to: 'followships#follow', as: 'follow'

  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
