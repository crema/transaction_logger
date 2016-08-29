# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'transaction_logger/version'

Gem::Specification.new do |spec|
  spec.name          = 'transaction-logger'
  spec.version       = TransactionLogger::VERSION
  spec.authors       = ['whonz']
  spec.email         = ['whonzmail@gmail.com']

  spec.summary       = 'active record transaction logger'
  spec.description   = ''
  spec.homepage      = 'https://github.com/cremame/transaction-logger'
  spec.license       = 'MIT'


  spec.files         = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activerecord', '~> 4.2.0'
  spec.add_runtime_dependency 'activesupport', '~> 4.2.0'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'mysql2', '~> 0.4.0'
end
