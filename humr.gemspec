# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'humr/version'

Gem::Specification.new do |spec|
  spec.name          = "humr"
  spec.version       = Humr::VERSION
  spec.authors       = ["motemen"]
  spec.email         = ["motemen@gmail.com"]
  spec.summary       = 'A CLI tool that make input human-readable'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'term-ansicolor', '~> 1'
  spec.add_runtime_dependency 'useragent', '~> 0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'terminal-notifier-guard'
  spec.add_development_dependency 'simplecov'
end
