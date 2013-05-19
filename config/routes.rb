require 'resque/server'

Staff::Application.routes.draw do

  mount Resque::Server, at: 'resque'

  ActiveAdmin.routes(self)

  devise_for :users, ActiveAdmin::Devise.config

  #resources :contacts

  #resources :week6
  #resources :week5

  match 'auth/key' => 'auth#key'
  devise_scope :user do
    get "auth/logout" => "devise/sessions#destroy"
  end
  match 'staff' => 'staff#index'
  #match 'staff/bootcamp' => 'bootcamp#index'
  #match 'staff/bootcamp/contacts' => 'bootcamp#contacts'
  #match 'staff/bootcamp/6' => 'bootcamp#week6'
  #match 'staff/bootcamp/5' => 'bootcamp#week5'
  match 'staff/accounts' => 'accounts#index'
  match 'staff/accounts/:id' => 'accounts#show'
  match 'staff/accounts/:id/transactions' => 'accounts#transactions'
  match 'staff/accounts/change_default_currency/:code' => 'accounts#change_default_currency'
  root :to => 'auth#home'

  #mount Ckeditor::Engine => '/ckeditor'
end
