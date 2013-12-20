source 'http://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

gem 'sorcery'

# Use sqlite3 as the database for Active Record
group :development do
  gem 'guard'
  gem 'ruby_gntp'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'rack-livereload'
  gem 'guard-livereload'
  gem 'guard-teaspoon'
  gem 'coffee-rails-source-maps'
  gem 'sprockets_better_errors'
end

group :production do
	gem 'pg'
end

group :development, :test do
	gem 'sqlite3'
  gem 'rspec-rails', '~> 2.0'
  gem 'spork-rails'
  gem 'factory_girl_rails'
  gem 'teaspoon'
end

group :debug do
  gem 'jazz_hands'
  gem 'pry-plus'
end

group :test do
  gem 'webmock'
  gem 'vcr'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem 'haml', '~> 4.0.3'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'angularjs-rails', '~> 1.2.0'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.5.2'

gem 'cancan', '~> 1.6.10'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use 'Phusion Passenger' as the app server
gem 'passenger'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'rails_12factor', group: :production

gem 'tire'

