Kelasi::Application.routes.draw do

  scope 'api_', module: :backend, defaults: {format: 'json'} do
    resources :users, except: [:index, :new, :edit, :update, :destroy] do
      get 'timelines', to: 'timelines#index'
    end

    resources :timelines, except: [:index, :new, :edit] do
      resources :members, only: [:index, :create]
      resources :posts,   only: [:index, :create]
    end
    resources :members, only: [:show, :update, :destroy]
    resources :posts,   only: [:show, :update, :destroy]

    resource :session, only: [:show, :create, :destroy], controller: 'session'
    get '/profile/:profile_name', to: 'profiles#show'
    get '/stream', to: 'streams#index'

    scope 'search' do
      post 'people',    to: 'search#people'
      post 'timelines', to: 'search#timelines'
    end
  end

  get '*path' => redirect('/')
end
