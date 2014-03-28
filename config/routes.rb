Kelasi::Application.routes.draw do

  scope 'api_', module: :backend, defaults: {format: 'json'} do
    resources :users do
      get 'timelines', to: 'timelines#index'
    end

    resources :timelines, except: [:index, :new, :edit] do
      resources :members, only: [:index, :create]
      resources :posts,   only: [:index, :create]
    end
    resources :members, only: [:show, :update, :destroy]
    resources :posts,   only: [:show, :update, :destroy]

    resource :session, only: [:show, :create, :destroy], controller: 'session'
    post 'search', to: 'search#search'
    get '/profile/:profile_name', to: 'profiles#show'
    get '/stream', to: 'streams#index'
  end

  get '*path' => redirect('/')
end
