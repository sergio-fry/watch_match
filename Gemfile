source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# app gems
gem 'nokogiri'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'inherited_resources'
gem 'therubyracer'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
group :production do
  gem 'pg'
end

group :development, :test do
  # Pretty printed test output
  #gem 'turn', :require => false

  gem 'factory_girl_rails'
  gem 'fakeweb'
  gem 'guard-rspec'
  gem 'heroku', :require => false
  gem 'jasmine'
  gem 'rspec-rails'
  gem 'spork'
  gem 'sqlite3'
  gem 'timecop'
end
