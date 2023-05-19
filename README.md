![Build Status](https://github.com/projectblacklight/blacklight-marc/actions/workflows/ruby.yml/badge.svg?branch=main)

# Blacklight::Marc 

MARC-specific enhancements for [Blacklight](https://github.com/projectblacklight/blacklight)

## Features
* Rake task `solr:marc:index` to import .mrc files using Traject and app/models/marc_indexer
* "Librarian View" at `catalog/:id/librarian_view`
* Export records to refworks and endnote
* Blacklight::Solr::Document mixins for exporting and transforming MARC data from a stored Solr field

## Installation

Add this line to your application's Gemfile:

    gem 'blacklight-marc'

And then execute:

    $ bundle

After running the blacklight generator, run the blacklight_marc generator:

    $ rails generate blacklight:marc:install


## How does it work?
This generator injects an include into CatalogController (parent class of BookmarksController):

```ruby
include Blacklight::Marc::Catalog
```

and the following code is generated into SolrDocument:

```ruby
use_extension( Blacklight::Marc::DocumentExtension) do |document|
  document.key?( :marc_display  )
end
```

This means, the extension will be applied on the instance if the backing hash
has a field called `marc_display`.


## Indexing
The generator will create a model called MarcIndexer. This model can be customized by modifying
the field configurations in its initializer as a Traject 2 indexer; new indexing behaviors can
be added to it via mixins or inline methods. Two example mixins are provided:
```ruby
MarcIndexer
  # you would add one or both of the mixins below
  include Blacklight::Marc::Indexer::Formats
  include Blacklight::Marc::Indexer::Dewey
  def initialize
    # and define fields as normal with the mixed-in methods
    to_field 'format', get_format
    to_field 'dewey100', dewey_facets(base: :hundreds)
    to_field 'dewey010', dewey_facets(base: :tens)
    to_field 'dewey_text', dewey_text
  end
end
```

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
