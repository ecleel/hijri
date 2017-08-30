source 'https://rubygems.org'

group :test, :development do
  gem 'minitest'

  if RUBY_VERSION < '1.9.3'
    gem 'rake', "< 11.0.1"
  else
    gem 'rake'
  end
end

gemspec
