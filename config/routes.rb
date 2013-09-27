require 'resque/server'

Staff::Application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config

  authenticated :user do
    mount Resque::Server, at: 'resque'
    ActiveAdmin.routes(self)

    devise_scope :user do
      get "auth/logout" => "devise/sessions#destroy"
    end

    namespace :staff do
      root :to => 'index#index'

      namespace :dmpd do
        root :to => 'index#index'
        match 'contacts' => 'index#contacts'
        resources :contacts
        resources :week6
        resources :week5
      end
      namespace :accounts do
        root :to => 'index#index'
        get ':id' => 'index#show'
        get ':id/transactions' => 'index#transactions'
        match 'change_default_currency/:code' => 'index#change_default_currency'
      end
    end
  end

  match 'auth/key' => 'auth#key'
  root :to => 'auth#home'
end
