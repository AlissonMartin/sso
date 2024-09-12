Rails.application.routes.draw do
  resources :oauth_clients
  devise_for :users
  devise_scope :user do
    get "signup", to: "devise/registrations#new"
    get "login", to: "devise/sessions#new"
    get "logout", to: "sessions#destroy"
  end

  authenticated :user do
    root 'home#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'devise/sessions#new'
    root 'devise/sessions#new', as: :unauthenticated_root
  end

  match '/auth/sso/authorize' => 'auth#authorize', via: :all
  match '/auth/sso/access_token' => 'auth#access_token', via: :all
  match '/auth/sso/user' => 'auth#user', via: :all
  match '/oauth/token' => 'auth#access_token', via: :all
end
