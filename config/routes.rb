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
      
    get '/403', to: 'errors#unauthorized', as: 'unauthorized'
    get '/404', to: 'errors#notfound', as: 'notfound'
    
    get '/home', to: 'home#index', as: 'home'

    get '/free_form', to: 'free_form_widget#index', as: 'free_form'
    post '/translate', to: 'free_form_widget#translate', as: 'translate'
    post '/export_free_translation', to: 'free_form_widget#export_free_translation', as: 'export_free_translation'
    
    get '/translation_request', to: 'free_form_widget#new_translation_request', as: 'new_translation_request'
    post '/translation_request', to: 'free_form_widget#create_translation_request', as: 'create_translation_request'

      # Upload ingredient through CSV file (CSV file Upload and parsing)
    get '/csv_upload', to: 'table_documents#csv_upload', as: 'csv_upload'

      # Parse CSV data
    post 'csv_parse', to: 'table_documents#csv_parse', as: 'csv_parse'

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

         put 'update_template_folder', to: 'template_documents#update_folder' 
        # Create or Update the Document and Translate
        
        put 'save_and_translate', to: 'template_documents#save_and_translate', as: 'save_and_translate'

        get 'preview', to: 'template_documents#preview', as: 'preview'

        # Print the Document in the PDF format
        get 'print', to: 'template_documents#print', as: 'print'

        #update status
        put 'update_status', to: 'template_documents#update_status', as: 'update_status'

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
        get 'clear', to: 'table_documents#clear', as: 'clear'

        #update status
        put 'update_status', to: 'table_documents#update_status', as: 'update_status'
        #update folder
        put 'update_table_folder', to: 'table_documents#update_folder' 
      end
    end
   
    # Update  Profile
    get 'edit_client_profile', to: 'client_profile#edit'
    put 'update_client_profile', to: 'client_profile#update'
    put 'update_client_password', to: 'client_profile#update_password'
    resources :user_subscriptions
    resources :user_subscriptions, only: [:create, :index, :update] do
     collection do
      put :update
      end
    end
    
    #Create Folder
      resources :document_folder
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
    get 'edit_profile', to: 'profile#edit'
    put 'update_profile', to: 'profile#update'
    put 'update_password', to: 'profile#update_password'
    
    #User Module Subscription
    resources :subscription_permissions , only: [:create, :index, :update] do
      collection do
        get '/add_edit_permissions/:id', to: 'subscription_permissions#create_pemission'
      end
    end
    
    
  
  end
  
end
