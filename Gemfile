# frozen_string_literal: true
source "https://rubygems.org"


gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'shotgun'
gem 'pry', :group => 'development'
gem 'bcrypt'
gem "tux"
gem 'puma'
gem 'rack-flash3'

group :development do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'activerecord-postgresql-adapter'
end 

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
