# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gemfile_utils/version'

Gem::Specification.new do |spec|
  spec.name          = "gemfile_utils"
  spec.version       = GemfileUtils::VERSION
  spec.authors       = ["Igor Fedoronchuk"]
  spec.email         = ["fedoronchuk@gmail.com"]

  spec.summary       = %q{gemfile_utils gem}
  spec.description   = %q{gemfile_utils provides command line interface to modify Gemfile with annotations and comments}
  spec.homepage      = "https://github.com/Fivell"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ['gemfile_utils']
  spec.require_paths = ['lib']

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_dependency "thor"
  spec.add_dependency "faraday"
  spec.add_dependency "typhoeus"
  spec.add_dependency "gemnasium-parser"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
