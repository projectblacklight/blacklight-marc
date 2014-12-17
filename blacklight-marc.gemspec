lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blacklight/marc/version'

Gem::Specification.new do |spec|
  spec.name          = "blacklight-marc"
  spec.version       = Blacklight::Marc::VERSION
  spec.authors       = ["Justin Coyne"]
  spec.email         = ["justin@curationexperts.com"]
  spec.description   = %q{MARC support for Blacklight}
  spec.summary       = %q{MARC support for Blacklight}
  spec.homepage      = "https://github.com/projectblacklight/blacklight_marc"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "blacklight", ">= 5.4.0.rc1", "< 6.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails", '~> 2.99'
  spec.add_development_dependency "jettywrapper"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "engine_cart", "~> 0.4"

  spec.add_dependency "rails"
  # Let's allow future versions of marc, count on
  # them to be backwards compat until 1.1
  spec.add_dependency "marc",      ">= 0.4.3", "< 1.1"  # Marc record parser.
end
