Ical::Application.routes.draw do

  namespace :admin do
    resources :usuarios
  end

  post 'login' => 'application#login'
  get 'logout' => 'application#logout'

  post 'replace' => 'home#replace'
  match '/:anyo' => "home#index"#, :id => /\d{4}/
  root :to => "home#index_query_string"

end
