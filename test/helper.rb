require 'rubygems'

begin
  require 'bundler'
rescue LoadError => e
  STDERR.puts e.message
  STDERR.puts "Run `gem install bundler` to install Bundler."
  exit e.status_code
end

begin
  Bundler.setup(:default, :development, :test)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems."
  exit e.status_code
end

if RUBY_VERSION < '1.8.8'
  require 'minitest/autorun'
end

require 'minitest/unit'

class MiniTest::Unit::TestCase
end

MiniTest::Unit.autorun
