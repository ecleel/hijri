# -*- encoding: utf-8 -*-

require File.expand_path('../lib/hijri/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "hijri"
  gem.version       = Hijri::VERSION
  gem.summary       = %q{Hijri Date Library for Ruby}
  gem.description   = %q{hijri is full Islamic Hijri calendar lib for ruby.}
  gem.license       = "MIT"
  gem.authors       = ["Abdulaziz AlShetwi"]
  gem.email         = "ecleeld@gmail.com"
  gem.homepage      = "https://github.com/ecleel/hijri"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'yard', '~> 0.8'
end
