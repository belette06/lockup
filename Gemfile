# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('./.ruby-version')

gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pry', '~> 0.12.2'
gem 'puma', '~> 3.11'
gem 'rails', '~> 6.0.0.rc1'
gem 'redis-rails'
gem 'sass-rails', '~> 5'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'
gem "pundit"
gem 'simple_form'
gem 'bootstrap-datepicker-rails'


group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.8'
end

group :development do
  gem 'annotate'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem "relaxed-rubocop"
  gem 'rubocop-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
