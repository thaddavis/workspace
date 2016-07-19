Rails.application.routes.draw do
  get 'home', to: 'pages#home'

  root to: 'pages#home'

  resources :recipes do
    member do
      post 'like'
    end
  end

  resources :chefs, except: [:new]

  get '/register', to: 'chefs#new'

  #login -> new session
  get '/login', to: 'logins#new'
  #logout -> close session
  get '/destroy', to: 'logins#destroy'
  #post login -> create session
  post '/login', to: 'logins#create'

end
