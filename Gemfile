# frozen_string_literal: true
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'rubocop', '~> 0.82.0'
  gem 'rubocop-rails', '~> 2.5'
  gem 'solargraph', '~> 0.38.6'
  gem 'pry-rails', '~> 0.3.9'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# The ruby implementation of the GraphQL language.
gem 'graphql', '~> 1.10'

# PostGIS Adapter
gem 'activerecord-postgis-adapter', '~> 6.0'

# RGeo
gem 'rgeo', '~> 2.1'
gem 'rgeo-shapefile', '~> 2.0'
gem 'rgeo-geojson', '~> 2.1'

gem 'nokogiri', '~> 1.10'
gem 'typhoeus', '~> 1.3'
gem 'redis', '~> 4.1'
gem 'sidekiq', '~> 6.0'
gem 'bugsnag', '~> 6.13'
