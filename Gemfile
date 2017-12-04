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
# Use Unicorn as the app server
gem 'unicorn'
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

# Sprockets ES6 transformer
# gem 'sprockets'
# gem 'sprockets-es6'

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
  gem 'awesome_print'
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

# A simple asset-pipeline wrapper for Vue.js by Evan You https://github.com/adambutler/vuejs-rails
gem 'vuejs-rails'

# the font-awesome font bundled as an asset for the rails asset pipeline https://github.com/bokmann/font-awesome-rails
# gem 'font-awesome-rails'

# http://fontawesome.io/get-started/
gem 'font-awesome-sass'

source 'https://rails-assets.org' do
  # Rails asset-pipeline gem to provide underscore.js
  gem 'rails-assets-underscore'
  # A browser detector https://github.com/lancedikson/bowser
  gem 'rails-assets-bowser'
  # Fast math typesetting for the web. https://khan.github.io/KaTeX/
  gem 'rails-assets-katex'
  # Simple HTML5 Charts using the <canvas> tag http://www.chartjs.org/
  gem 'rails-assets-chartjs'
  # NOTY is a notification library that makes it easy to create alert - success - error - warning - information - confirmation messages as an alternative the standard alert dialog.
  gem 'rails-assets-noty'
  # A JavaScript library for binding keyboard combos without the pain of key codes and key combo conflicts. https://github.com/RobertWHurst/KeyboardJS
  gem 'rails-assets-KeyboardJS'
  # A set of javascript tools for working with files. http://mailru.github.io/FileAPI/
  gem 'rails-assets-FileAPI'
  # Javascript audio library for the modern web. https://github.com/goldfire/howler.js
  # gem 'rails-assets-howler'
  # Full featured context menu handler capable of handling thousands of elements https://swisnl.github.io/jQuery-contextMenu/
  # gem 'rails-assets-jQuery-contextMenu'
  # Beautifier for javascript http://jsbeautifier.org/
  # gem 'rails-assets-js-beautify'
  # Sortable — is a JavaScript library for reorderable drag-and-drop lists on modern browsers and touch devices. No jQuery. Supports Meteor, AngularJS, React, Polymer, Knockout and any CSS library, e.g. Bootstrap. http://rubaxa.github.io/Sortable/
  gem 'rails-assets-sortablejs'
end

# Rails engine with helpers and JavaScript for displaying times and dates to users in their local time
gem 'local_time'

# Ruby lib for reading/writing/modifying .xlsx and .xlsm files https://github.com/weshatheleopard/rubyXL
gem 'rubyXL'
