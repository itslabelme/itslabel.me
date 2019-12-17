Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  devise_for :client_users, path: "users", path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  devise_for :admin_users, path: "admin", skip: [:registrations], path_names: { sign_in: 'login', sign_out: 'logout', edit: 'settings' }


  root to: "home#index"
  get '/home', to: 'home#index', as: 'home'
  
end
