Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'confirmations'}
  resources :notes do
    get 'delete'
    get 'important', on: :member
    get 'unimportant', on: :member
 collection do
     get 'search'
     get 'tagged', to: "notes#tagged", as: :tagged
     get 'autosave'
     get 'noautosave'
 end
    resources :comments
  end

  root 'notes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
