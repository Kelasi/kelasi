source 'http://rubygems.org'
ruby '2.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'

gem 'sorcery'

# Use sqlite3 as the database for Active Record
group :development do
  gem 'spring'
  gem 'guard'
  gem 'ruby_gntp'
  gem 'guard-rspec'
  gem 'rack-livereload'
  gem 'guard-livereload'
end

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'jazz_hands'
  gem 'pry-plus'
end

group :test do
  gem 'webmock'
  gem 'vcr'
  gem 'fivemat'
end

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Use 'Phusion Passenger' as the app server
gem 'passenger', group: :production

gem 'rails_12factor', group: :production

gem 'tire'

gem 'kaminari'
