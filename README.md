[![Build Status](https://travis-ci.org/projectblacklight/blacklight_marc.png?branch=master)](https://travis-ci.org/projectblacklight/blacklight_marc)

# Blacklight::Marc

MARC-specific enhancements for [Blacklight](https://github.com/projectblacklight/blacklight)

## Installation

Add this line to your application's Gemfile:

    gem 'blacklight-marc'

And then execute:

    $ bundle

After running the blacklight generator, run the blacklight_marc generator:

    $ rails generate blacklight_marc:marc

## Features
* Rake task `solr:marc:index` to import .mrc files using SolrMarc
* Librarian view at `catalog/:id/librarian_view`
* Export records to refworks and endnote
* Blacklight::Solr::Document mixins for exporting and transforming MARC data from a stored Solr field


## Documentation, Information and Support

* [Project Homepage](http://projectblacklight.org)
* [Developer Documentation](https://github.com/projectblacklight/blacklight/wiki)
* [Quickstart Guide](https://github.com/projectblacklight/blacklight/wiki/Quickstart)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
