source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
gem 'mysql2'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'better_errors'
  gem 'letter_opener'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Slim is a template language whose goal is reduce the syntax to the essential parts without becoming cryptic.
gem 'slim'

# Simple Rails app configuration
gem 'figaro'

# Exception Notifier Plugin for Rails
gem 'exception_notification'
# A simple wrapper for posting to slack channels
gem 'slack-notifier'

# Flexible authentication solution for Rails with Warden
gem 'devise'
gem 'devise_lastseenable'

# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Ruby webapps
gem 'kaminari'

# Easy file attachment management for ActiveRecord
gem 'paperclip'
# Rails jQuery file uploads via standard Rails "remote: true" forms.
gem 'remotipart'

# Simple HTTP and REST client for Ruby
gem 'rest-client'
# Nokogiri (鋸) is a Rubygem providing HTML, XML, SAX, and Reader parsers with XPath and CSS selector support. http://nokogiri.org/
gem 'nokogiri'
gem 'mechanize'
# Domain name parser for Ruby based on the Public Suffix List.
gem 'public_suffix'

# Forms made easy for Rails! It's tied to a simple DSL, with no opinion on markup
gem 'simple_form'
gem 'nested_form'
gem 'validates_timeliness'

# Sass-powered version of Semantic UI and ready to drop into Rails & Compass.
gem 'semantic-ui-sass'
# Rails asset-pipeline gem to provide underscore.js
gem 'underscore-rails'
# an asset gem containing Adam Shaw's excellent fullcalendar jquery plugin
gem 'fullcalendar-rails'
gem 'momentjs-rails'

source 'https://rails-assets.org' do
  # Drag and drop so simple it hurts https://bevacqua.github.io/dragula/
  gem 'rails-assets-dragula'
  # NOTY is a notification library that makes it easy to create alert - success - error - warning - information - confirmation messages as an alternative the standard alert dialog.
  gem 'rails-assets-noty'
  # Fast math typesetting for the web. https://khan.github.io/KaTeX/
  gem 'rails-assets-katex'
end

# Rails engine with helpers and JavaScript for displaying times and dates to users in their local time
gem 'local_time'
