Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'confirmations'}
  resources :notes do
    member do
      get 'delete'
      get 'important'
      get 'unimportant'
      get 'sharenotes/editaccess'
      get 'sharenotes/updatepermission'
    end
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
