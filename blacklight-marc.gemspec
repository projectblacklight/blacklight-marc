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
  spec.homepage      = "https://github.com/projectblacklight/blacklight-marc"
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'blacklight', '>= 7.11', '< 9'
  spec.add_dependency "library_stdnums"
  spec.add_dependency "rails"
  spec.add_dependency "marc",      ">= 0.4.3", "< 2.0"  # Marc record parser.
  spec.add_dependency "traject", "~>3.0"
  spec.add_dependency 'marc-fastxmlwriter' # NO REXML

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails", '~> 7.0'
  spec.add_development_dependency "rspec-activemodel-mocks"
  spec.add_development_dependency "solr_wrapper"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "engine_cart", "~> 2.0"
end
