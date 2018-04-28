source 'https://rubygems.org'
ruby "2.4.1"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'bootstrap-sass', '3.3.7'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'font-awesome-rails'
# to parse markdown text to html
gem 'kramdown', '~> 1.12.0'
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# for authorization based on roles
gem 'pundit', '1.1.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.0'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use Webpack to manage app-like JavaScript modules in Rails with Yarn
gem 'webpacker', '~> 3.4'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Use sqlite3 as the database for Active Record
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'pry-rails'
  gem 'teaspoon-jasmine'
end

group :test do
  gem 'capybara', '~> 2.13.0'
  gem 'cucumber-rails', require: false
  gem 'cucumber-rails-training-wheels'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'guard-rspec', require: false
  gem 'phantomjs'
  gem 'poltergeist'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
