source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# ruby '3.0.1'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '6.1'
# gem "sprockets-rails"
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
# gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
# gem 'yaaf'
gem 'enum_help'
gem 'kaminari'
gem 'ransack'
# gem 'bcrypt', '~> 3.1.7'
# gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
gem 'image_processing', '~> 1.2'
gem 'unicorn'
# gem 'ed25519', '>= 1.2', '< 2.0'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'dotenv-rails'

gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
# gem 'omniauth'
# gem 'omniauth-google-oauth2'
# gem 'omniauth-rails_csrf_protection'
gem 'recaptcha', require: 'recaptcha/rails'

# gem 'geocoder'
# gem 'gon'

gem 'payjp'

gem 'faker'
gem 'gimei'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capistrano', "~> 3.10", require: false
  gem 'capistrano-rails', "~> 1.6", require: false
  gem 'capistrano-safe-deploy-to'
  gem 'capistrano-rbenv'
  # gem 'capistrano-bundler'
  gem 'capistrano3-unicorn'
  gem 'rspec-rails', '~> 4.0.2'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener_web'
  gem 'listen', '~> 3.2'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'spring', '>= 3'
  gem 'spring-watcher-listen', '~> 2.1.0'
  gem 'web-console', '>= 3.3.0'
  # gem 'rails_best_practices'
end

group :test do
  # gem 'rspec-parameterized'
  gem 'shoulda-matchers'
  gem 'timecop'
  # gem 'database_cleaner-active_record'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
