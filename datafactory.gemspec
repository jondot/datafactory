# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'datafactory/version'

Gem::Specification.new do |spec|
  spec.name          = "datafactory"
  spec.version       = Datafactory::VERSION
  spec.authors       = ["Dotan Nahum"]
  spec.email         = ["jondotan@gmail.com"]

  spec.summary       = %q{A tool that helps you generate data into multiple databases}
  spec.description   = %q{A tool that helps you generate data into multiple databases}
  spec.homepage      = "https://github.com/jondot/datafactory"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor', '~> 0.19.1'
  spec.add_dependency 'mongoid', '~> 5.0.2'
  spec.add_dependency 'sequel', '~> 4.25.0'
  spec.add_dependency 'activerecord', '~> 4.2.5.1'
  spec.add_dependency 'factory_girl', '~> 4.5.0'
  spec.add_dependency 'faker', '~> 1.6.1'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
