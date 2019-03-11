# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { confirmations: 'confirmations' }
  resources :notes do
    member do
      get 'delete'
      get 'important'
      get 'unimportant'
      get 'sharenotes/editaccess'
      get 'sharenotes/updatepermission'
      get 'charges/refund'
    end
    collection do
      get 'search'
      get 'tagged', to: 'notes#tagged', as: :tagged
      get 'autosave'
      get 'noautosave'
      get 'sharenotes/index'
      get 'sharenotes/shownote'

    end
    resources :comments, except: %i[index show]
    resources :sharenotes, only: %i[new create]
    resources :charges
  end
  #   resources :charges,  only: :create
  # post 'create_charge' , to: 'charges#create', as: 'create_charge'
  root 'notes#index'
end
