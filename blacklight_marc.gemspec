lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blacklight_marc/version'

Gem::Specification.new do |spec|
  spec.name          = "blacklight_marc"
  spec.version       = BlacklightMarc::VERSION
  spec.authors       = ["Justin Coyne"]
  spec.email         = ["justin@curationexperts.com"]
  spec.description   = %q{SolrMarc support for Blacklight}
  spec.summary       = %q{SolrMarc support for Blacklight}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "jettywrapper"
  spec.add_dependency "rails"
  # Let's allow future versions of marc, count on
  # them to be backwards compat until 1.1
  spec.add_dependency "marc",      ">= 0.4.3", "< 1.1"  # Marc record parser.
end
