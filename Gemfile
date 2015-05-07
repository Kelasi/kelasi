source 'http://rubygems.org'
ruby '2.1.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'

gem 'sorcery'
gem 'pg'
gem 'jbuilder'
gem 'tire'
gem 'kaminari'
gem 'carrierwave'
gem 'carrierwave_backgrounder'
gem "mini_magick"

gem "resque", "~> 2.0.0.pre.1", github: "resque/resque"

group :development do
  gem 'spring'
  gem 'guard'
  gem 'ruby_gntp'
  gem 'guard-rspec'
  gem 'rack-livereload'
  gem 'guard-livereload'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  # gem 'jazz_hands'
  # gem 'pry-plus'
end

group :test do
  gem 'webmock'
  gem 'vcr'
  # gem 'fivemat'
end

group :production do
  gem 'passenger'
  gem 'rails_12factor'
end
