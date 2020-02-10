Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  devise_for :client_users, path: "user", path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' },:controllers => { :omniauth_callbacks => "user/omniauth_callbacks" } do
    get '/user/auth/:provider' => 'user/omniauth_callbacks#passthru'
  end

  devise_scope :client_user do
    # root to:'home#index'
    root to: "devise/sessions#new"
  end

  namespace :user, module: :user do

    get '/home', to: 'home#index', as: 'home'
    post '/try', to: 'home#try', as: 'try'

    root to: 'home#index'
    
    # CRUD Documents
    resources :documents do
      member do
        get 'print', to: 'documents#print', as: 'print'
        put 'save_and_translate', to: 'documents#save_and_translate', as: 'save_and_translate'
      end
      collection do
        get 'select_template', to: 'documents#select_template', as: 'select_template'
      end
    end
    
    resources :client_profile, only: [:edit, :update] do
      collection do
        patch :update_client_password # /transactions/sum or the sum of all transactions.
     end
end
  end
  
  devise_for :admin_users, path: "admin", skip: [:registrations], path_names: { sign_in: 'login', sign_out: 'logout', edit: 'settings' }

  namespace :admin, module: :admin do
    get '/home', to: 'home#index', as: 'home'
    root to: 'home#index'
    # CRUD Client Users
    resources :client_users

    # CRUD Admin Users
    resources :admin_users    
    resources :admin_users    

    # CRUD Translations
    resources :translations

    # CRUD Translations
    resources :label_templates
    
    # CRUD Translations
    resources :profile
     patch 'update_password', to: 'profile#update_password'
  end
  
end
