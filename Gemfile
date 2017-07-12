source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.1'

gem 'pg', '~> 0.18'

gem 'bcrypt', '~> 3.1.7'

gem 'puma'

gem 'redis', '~> 3.0'

gem 'rack-cors'

gem 'jwt'

gem 'dotenv-rails'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'pry'
  gem 'shoulda', '~> 3.5'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
