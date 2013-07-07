source 'https://rubygems.org'
ruby '2.0.0' # Heroku's ruby version

gem 'rails', '4.0.0'

gem 'pg'

gem 'sass-rails', '~> 4.0.0'

gem 'therubyracer', platforms: :ruby

gem 'uglifier', '>= 1.3.0'

gem 'anjlab-bootstrap-rails', '~> 2.2.1', require: 'bootstrap-rails'

gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'clearance', '1.0.0.rc7'

gem 'thin'

gem 'rails_12factor', group: :production

group :development, :test do
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-debugger'
end

group :test do
  gem 'rspec-rails', '>= 2.5.0'
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'selenium-webdriver'
  gem 'cucumber-rails', :require => false # http://stackoverflow.com/questions/9866264/warning-cucumber-rails-required-outside-of-env-rb
  gem 'database_cleaner'
end
