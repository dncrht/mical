Ical::Application.routes.draw do

  post 'replace' => 'home#replace'
  match '/:anyo' => "home#index"#, :id => /\d{4}/
  root :to => "home#index_query_string"

end
