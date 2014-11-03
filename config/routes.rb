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
      get 'leaderboard' => 'index#leaderboard'
      resource :user, only: [:edit, :update]
      namespace :dmpd do
        root 'index#index'
        get 'signup' => 'index#signup'
        resources :contacts
        resources :appointment_set_records
        resources :taskset
        namespace :stats do
          root to: 'base#index'
          resources :appointment_set_record
          resources :support_raising_development
          resources :contact_card_box
        end
      end
      resources :reports
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
          get 'change_default_currency/:code' =>
            'accounts#change_default_currency'
        end
      end
    end
  end

  get 'auth/key' => 'auth#key'
  root to: 'auth#index'
  get '*path' => redirect('/')

end
