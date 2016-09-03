source 'https://rubygems.org'

group :test, :development do
  if %w(1.8.7 2.2.0 2.2.2 2.3.0 2.3.1).include? RUBY_VERSION
    gem 'minitest'
  end
  
  if RUBY_VERSION < '1.9.3'
    gem 'rake', "< 11.0.1"
  else
    gem 'rake'
  end
end

gemspec