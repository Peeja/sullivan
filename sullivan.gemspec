# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sullivan/version'

Gem::Specification.new do |spec|
  spec.name          = "sullivan"
  spec.version       = Sullivan::VERSION
  spec.authors       = ["Peter Jaros"]
  spec.email         = ["peter.a.jaros@gmail.com"]
  spec.summary       = %q{A simple, composable way to validate the structure of data.}
  spec.description   = %q{A simple, composable way to validate the structure of data. "Form ever follows function. This is the law." — Louis Henry Sullivan}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.1.5"
end
