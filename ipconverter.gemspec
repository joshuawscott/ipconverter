lib = File.expand_path('lib', __dir__)
ext = File.expand_path('ext', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
$LOAD_PATH.unshift(ext) unless $LOAD_PATH.include?(ext)
require 'ipconverter/version'

Gem::Specification.new do |spec|
  spec.name          = 'ipconverter'
  spec.version       = IpConverter::VERSION
  spec.authors       = ['Joshua Scott']
  spec.email         = ['joshua.scott@gmail.com']
  spec.summary       = 'Utilities for working with IP addresses'
  spec.description   = 'Fast C extension for converting IP addresses from
string to integer'
  spec.homepage      = 'http://github.com/joshuawscott/ipconverter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.extensions    = ['ext/ipconverter/extconf.rb']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w[lib ext]

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest', '~> 5'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rake-compiler', '~> 1.0'
  spec.add_development_dependency 'rubocop', '~> 0.50'
end
