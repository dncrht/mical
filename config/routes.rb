Ical::Application.routes.draw do

  post 'replace' => 'home#replace'
  root :to => "home#index"

end
