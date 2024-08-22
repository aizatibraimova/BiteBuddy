source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

gem "bootsnap", require: false
gem "devise"
gem "importmap-rails"
gem "jbuilder"
gem "kaminari"
gem "openai"
gem "pg", "~> 1.1"
gem "puma"
gem "pundit"
gem "ransack"
gem "redis", "~> 4.0"
gem "ruby-openai"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "faker"
  gem "rspec-rails", "~> 6.0.0"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "draft_matchers"
  gem "rspec-html-matchers"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "webmock"
end

# AppDev Gems
# ===========
gem "appdev_support"
gem "awesome_print"
gem "dotenv-rails"
gem "faker"
gem "htmlbeautifier"
gem "http"
gem "sqlite3", "~> 1.4"
gem "table_print"

group :development do
  gem "annotate"
  gem "better_errors"
  gem "binding_of_caller"
  gem "draft_generators"
  gem "grade_runner"
  gem "pry-rails"
  gem "rails_db"
  gem "rails-erd"
  gem "rufo"
  gem "specs_to_readme"
  gem "web-console"
end
