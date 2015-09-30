Mical::Application.routes.draw do

  namespace :admin do
    resources :users
    resources :activities
  end

  get 'admin' => 'admin#index'

  resources :events, only: %i(show create update destroy)
  match ':year' => 'home#index', year: /\d{4}/, via: [:get, :post], as: 'year'
  root 'home#index'

end
