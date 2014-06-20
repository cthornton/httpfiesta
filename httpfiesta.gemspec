# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'httpfiesta/version'

Gem::Specification.new do |spec|
  spec.name          = 'httpfiesta'
  spec.version       = HTTPFiesta::VERSION
  spec.authors       = ['Christopher Thornton', 'Ben Radler']
  spec.email         = ['rmdirbin@gmail.com', 'ben@benradler.com']
  spec.summary       = %q{Makes verifying your HTTParty responses easier!}
  spec.description   = %q{Adds some extra utilities to make verifying your HTTParty responses more convienent and fun}
  spec.homepage      = 'https://github.com/cgthornt/httpfiesta'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 1.9.3'


  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0.0'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'json'
  spec.add_development_dependency 'httparty'
end
