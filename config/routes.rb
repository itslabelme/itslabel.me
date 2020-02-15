Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  devise_for :client_users, path: "user", path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' },:controllers => { :omniauth_callbacks => "user/omniauth_callbacks" } do
    get '/user/auth/:provider' => 'user/omniauth_callbacks#passthru'
  end

  devise_scope :client_user do
    
    # Landing Page will always be Client Login
    root to: "devise/sessions#new"
    
  end

  namespace :user, module: :user do

    get '/home', to: 'home#index', as: 'home'
    post '/try', to: 'home#try', as: 'try'

    root to: 'home#index'
    
    # Listing All Kinds of Documents
    resources :documents, only: [:index, :destroy] do
      # Update the status of the document
      member do
        put :update_status
      end
    end

    # CRUD Template Documents
    resources :template_documents do
      member do

        # Create or Update the Document and Translate
        put 'save_and_translate', to: 'template_documents#save_and_translate', as: 'save_and_translate'

        get 'preview', to: 'template_documents#preview', as: 'preview'

        # Print the Document in the PDF format
        get 'print', to: 'template_documents#print', as: 'print'

      end

      collection do
        get 'select_template', to: 'template_documents#select_template', as: 'select_template'
      end
    end

    # CRUD Table Documents
    resources :table_documents do
      
      collection do
        # Save Methods
        put 'save_everything', to: 'table_documents#save_everything', as: 'save_everything'
        put 'translate_input_phrase', to: 'table_documents#translate_input_phrase', as: 'translate_input_phrase'
      end

      member do
        # Export to Excel
        get 'export_to_excel', to: 'table_documents#export_to_excel', as: 'export_to_excel'
      end
    end
    
    resources :client_profile, only: [:edit, :update] do
      collection do
        patch :update_client_password # /transactions/sum or the sum of all transactions.
     end
    end
     get 'get_time_zone', to: 'ajax_call#get_time_zone' 
  end
  
  devise_for :admin_users, path: "admin", skip: [:registrations], path_names: { sign_in: 'login', sign_out: 'logout', edit: 'settings' }

  namespace :admin, module: :admin do

    # Admin Home
    get '/home', to: 'home#index', as: 'home'
    
    # FIXME - not sure why we need this
    root to: 'home#index'

    # CRUD Client Users
    resources :client_users

    # CRUD Admin Users
    resources :admin_users    

    # CRUD Translations
    resources :translations

    # CRUD Label Templates
    resources :label_templates

    # CRUD Nutrition Fact Templates
    # resources :nutrition_fact_templates
    
    # Update Admin Profile
    resources :profile
    patch 'update_password', to: 'profile#update_password'
  end
  
end
