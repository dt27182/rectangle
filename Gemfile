source 'http://rubygems.org'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


gem 'jquery-rails'
gem 'haml'
gem 'devise'
gem 'paperclip', '~> 3.0'
gem 'aws-sdk'
gem "dynamic_form"
gem 'omniauth-facebook'

group :test do
  gem 'cucumber-rails'
  gem 'cucumber-rails-training-wheels'
end
  
group :development, :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'sqlite3'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'linecache19', :git => 'git://github.com/mark-moseley/linecache'
  gem 'ruby-debug-base19x', '~> 0.11.30.pre4'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'ZenTest'
  gem 'minitest'
end

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'therubyracer'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'


