require 'resque/server'

Staff::Application.routes.draw do

  devise_for :users, ActiveAdmin::Devise.config

  authenticated :user do
    mount Resque::Server, at: 'resque'
    ActiveAdmin.routes(self)

    devise_scope :user do
      get 'auth/logout' => 'devise/sessions#destroy'
    end

    scope module: :staff do
      resources :documents
      root to: 'index#index', as: :authenticated_root
      get 'since-youve-been-gone' => 'index#roadblock'
      resources :players, only: [:index] do
        collection do
          get 'signup'
        end
      end
      resources :users, only: [:index, :show] do
        collection do
          get 'signup'
        end
      end
      resource :user, only: [:edit, :update]
      get 'dmpd', to: 'dmpd#index'
      get 'dmpd/signup' => 'dmpd#signup'
      namespace :dmpd do
        resources :contacts
        resources :taskset
      end
      resources :reviews do
        collection do
          get 'signup'
        end
      end
      resources :gma_organizations, only: [:index] do
        collection do
          get 'signup'
        end
        resources :gma_staff_reports, only: [:index, :edit, :update]
      end
      resources :accounts do
        member do
          get 'transactions'
        end
        collection do
          get 'signup'
        end
      end
    end
  end

  get 'auth/key' => 'auth#key'
  root to: 'auth#index'
  get '*path' => redirect('/')

end
