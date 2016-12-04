# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'foreign_exchange/version'

Gem::Specification.new do |spec|
  spec.name          = "foreign_exchange"
  spec.version       = ForeignExchange::VERSION
  spec.authors       = ["Rob Hesketh"]
  spec.email         = ["rhesketh.uk@gmail.com"]

  spec.summary       = %q{Provides current and historical foreign exchange rates}

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~>3.5.0"
end
