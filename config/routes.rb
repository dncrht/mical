Mical::Application.routes.draw do

  namespace :admin do
    resources :users
    resources :activities
  end

  get 'admin' => 'admin#index'

  put 'action' => 'home#replace'
  delete 'action' => 'home#destroy'
  match ':year' => 'home#index', year: /\d{4}/, via: [:get, :post], as: 'year'
  root 'home#index'

end
