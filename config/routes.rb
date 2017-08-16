Rails.application.routes.draw do

  namespace :admin do
    resources :users
    resources :activities
    resources :events, only: [:index, :create]
  end

  get 'admin' => 'admin#index'

  namespace :api do
    resources :photos, only: :create
  end

  resources :events, only: %i(show create update destroy)
  resources :photos, only: %i(create destroy)
  match ':year' => 'home#index', year: /\d{4}/, via: [:get, :post], as: 'year'
  root 'home#index'

end
