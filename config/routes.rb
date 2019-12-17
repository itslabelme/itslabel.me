Rails.application.routes.draw do
  
  # devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  devise_for :client_users, path: "users", path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  devise_for :admin_users, path_names: { sign_in: 'a_login', sign_out: 'alogout', sign_up: 'a_register', edit: 'a_settings' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
  get '/home', to: 'home#index', as: 'home'
  
end
