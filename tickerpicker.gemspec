# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tickerpicker/version'

Gem::Specification.new do |spec|
  spec.name          = "tickerpicker"
  spec.version       = TickerPicker::VERSION
  spec.authors       = ["Mustafa Turan"]
  spec.email         = ["mustafaturan.net@gmail.com"]
  spec.description   = %q{A generalized ticker picker library for cryto currencies like #BTC(bitcoin), #LTC(litecoin) in world stock markets.}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/mustafaturan/tickerpicker"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "hashable", "~> 0.1.2"
end
