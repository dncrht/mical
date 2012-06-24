Ical::Application.routes.draw do

  namespace :admin do
    resources :users
    resources :activities
  end

  get 'admin' => 'admin#index'
  post 'login' => 'admin#login'
  get 'logout' => 'admin#logout'

  put 'action' => 'home#replace'
  delete 'action' => 'home#destroy'
  match ':anyo' => "home#index"#, :id => /\d{4}/
  root :to => "home#index_query_string"

end
