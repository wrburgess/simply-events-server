source "https://rubygems.org"

ruby "2.3.1"
gem "rails", "5.0.0.1"

gem "active_model_serializers", "0.10.2"
gem "bcrypt", "3.1.11"
gem "faker", "1.6.6"
gem "figaro", "1.1.1"
gem "jquery-rails", "4.2.1"
gem "jwt", "1.5.6"
gem "pg", "0.19.0"
gem "postmark-rails", "0.14.0"
gem "raygun4ruby", "1.1.11"
gem "redis-rails", "5.0.1"
gem "rollbar", "2.13.3"
gem "sass-rails", "5.0.6"
gem "settingslogic", "2.0.9"
gem "sidekiq", "4.2.3"
gem "sinatra", "2.0.0.beta2"
gem "thor-rails", "0.0.1"
gem "uglifier", "3.0.3"

group :production, :staging do
  gem "puma", "3.6.0"
end

group :development, :test do
  gem "brakeman", "3.4.0", require: false
  gem "bundler-audit", "0.5.0", require: false
  gem "byebug", "9.0.6"
  gem "factory_girl_rails", "4.7.0"
  gem "hakiri", "0.7.2", require: false
  gem "pry-rails", "0.3.4"
  gem "pry-remote", "0.1.8"
  gem "rubocop", "0.44.1"
end

group :development do
  gem "listen", "3.1.5"
  gem "web-console", "3.4.0"
  gem "rails_db", "1.3.4"
end

group :test do
  gem "airborne", "0.2.5" # 0.2.6 activesupport conflict
  gem "capybara", "2.10.1"
  gem "database_cleaner", "1.5.3"
  gem "rspec-instafail", "1.0.0"
  gem "rspec-json_expectations", "1.4.0"
  gem "rspec-rails", "3.5.2"
  gem "rspec-sidekiq", "2.2.0"
  gem "rspec_junit_formatter", "0.2.3"
  gem "rubocop-rspec", "1.8.0"
  gem "shoulda-matchers", "3.1.1"
end
