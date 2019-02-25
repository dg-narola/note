Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'confirmations'}
  resources :notes do
    get 'delete'
    get 'important', on: :member
    get 'unimportant', on: :member
    get 'sharenotes/editaccess', on: :member
    get 'sharenotes/updatepermission', on: :member
    collection do
      get 'search'
      get 'tagged', to: "notes#tagged", as: :tagged
      get 'autosave'
      get 'noautosave'
      get 'sharenotes/index'
      get 'sharenotes/shownote'
    end
    resources :comments
    resources :sharenotes, except: :index

  end

  root 'notes#index'
end
