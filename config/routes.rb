Rails
  .application
  .routes
  .draw do
    namespace :staff, path: '' do
      root 'top#index'
      get 'login' => 'sessions#new', :as => :login
      resource :session, only: %i[create destroy]
      resouce :account, except: %i[new create destroy]
    end

    namespace :admin do
      root 'top#index'
      get 'login' => 'sessions#new', :as => :login
      resource :session, only: %i[create destroy]
      resources :staff_members
    end

    namespace :customer do
      root 'top#index'
    end
  end
