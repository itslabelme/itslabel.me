Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  devise_for :client_users, path: "user", path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  devise_for :admin_users, path: "admin", skip: [:registrations], path_names: { sign_in: 'login', sign_out: 'logout', edit: 'settings' }

  devise_scope :client_user do
    
    root to: "devise/sessions#new"

    # CRUD Documents
    resources :documents
  end

  namespace :user, module: :user do
    get '/home', to: 'home#index', as: 'home'
  end

  namespace :admin, module: :admin do
    get '/home', to: 'home#index', as: 'home'

    # CRUD Client Users
    resources :client_users

    # CRUD Admin Users
    resources :admin_users    

    # CRUD Translations
    resources :translations

    # CRUD Translations
    resources :templates
  end
  
end
