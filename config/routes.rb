Rails
  .application
  .routes
  .draw do
    config = Rails.application.config.baukis2

    constraints host: config[:staff][:host] do
      namespace :staff, path: config[:staff][:path] do
        root 'top#index'
        get 'login' => 'sessions#new', :as => :login
        resource :session, only: %i[create destroy]
        resource :account, except: %i[new create destroy] do
          patch :confirm
        end
        resource :password, only: %i[show edit update]
        resources :customers
        resources :programs do
          resources :entries, only: [] do
            patch :update_all, on: :collection
          end
        end
        get 'messages/count' => 'ajax#message_count'
        resources :messages, only: %i[index show destroy] do
          get :inbound, :outbound, :deleted, on: :collection
        end
      end
    end

    constraints host: config[:admin][:host] do
      namespace :admin, path: config[:admin][:path] do
        root 'top#index'
        get 'login' => 'sessions#new', :as => :login
        resource :session, only: %i[create destroy]
        resources :staff_members do
          resources :staff_events, only: [:index]
        end
        resources :staff_events, only: [:index]
        resources :allowed_sources, only: %i[index create] do
          delete :delete, on: :collection
        end
      end
    end

    constraints host: config[:customer][:host] do
      namespace :customer, path: config[:customer][:path] do
        root 'top#index'
        get 'login' => 'sessions#new', :as => :login

        resource :session, only: %i[create destroy]
        resource :account, except: %i[new create destroy] do
          patch :confirm
        end
        resources :programs, only: %i[index show] do
          resource :entry, only: [:create] do
            patch :cancel
          end
        end
        resources :messages, only: %i[new create] do
          post :confirm, on: :collection
        end
      end
    end
  end
