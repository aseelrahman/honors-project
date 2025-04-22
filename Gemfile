# Gemfile
source "https://rubygems.org"

ruby "3.3.4"

gem "rails", "~> 8.0.2"
gem "pg", "~> 1.1"
gem "sqlite3", "~> 2.1"  # Specifies SQLite 2.1 or newer
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "bcrypt", "~> 3.1.7"
gem "image_processing", "~> 1.2"
gem "stripe"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console"
  gem "letter_opener"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end