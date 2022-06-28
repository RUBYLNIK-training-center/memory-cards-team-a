source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'rails', '~> 6.1.5', '>= 6.1.5.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'devise'
gem 'webpacker', '~> 5.0'
gem 'jbuilder', '~> 2.7'
gem 'rubocop-rails', '>= 2.14.2'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'redcarpet'
gem 'coderay'
gem 'activeadmin'
gem 'active_skin'
gem 'active_storage_validations'
gem 'rails-i18n'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'activerecord-session_store'
gem "omniauth-rails_csrf_protection"
gem "google-cloud-storage", "~> 1.8", require: false
gem 'sidekiq', '~>6.5.0'
gem 'enumerize'

gem "turbo-rails"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rubocop-rspec', require: false
  gem 'pry', '~> 0.13.1'
  gem 'simplecov', require: false
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Use Redis for Action Cable
gem 'redis', '~> 4.0'
