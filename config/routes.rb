Ical::Application.routes.draw do

  namespace :admin do
    resources :usuarios
    resources :actividades
  end

  get 'admin' => 'admin#index'

  post 'login' => 'application#login'
  get 'logout' => 'application#logout'

  put 'action' => 'home#replace'
  delete 'action' => 'home#destroy'
  match ':anyo' => "home#index"#, :id => /\d{4}/
  root :to => "home#index_query_string"

end
