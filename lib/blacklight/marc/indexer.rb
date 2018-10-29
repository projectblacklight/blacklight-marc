require 'library_stdnums'
require 'traject'
require 'traject/null_writer'
require 'traject/macros/marc21_semantics'

require 'traject/macros/marc_format_classifier'

require 'traject/solr_json_writer'
require 'traject/marc_reader'
require 'marc/fastxmlwriter'

class Blacklight::Marc::Indexer < Traject::Indexer::MarcIndexer
  autoload :Dewey, 'blacklight/marc/indexer/dewey'
  autoload :Formats, 'blacklight/marc/indexer/formats'

  include  Traject::Macros::Marc21Semantics
  include Traject::Macros::MarcFormats

  ATOZ = ('a'..'z').to_a.join('')
  ATOU = ('a'..'u').to_a.join('')

  def initialize
    super

    settings do
      provide "reader_class_name", "Traject::MarcReader"
      if c = Blacklight.connection_config
        provide "solr.url", c[:url]
      end
      provide "solr_writer.commit_on_close", "true"
      provide "solr_writer.thread_pool", 1
      provide "solr_writer.batch_size", 100
      provide "writer_class_name", "Traject::SolrJsonWriter"
      provide 'processing_thread_pool', 1
      provide "log.batch_size", 10_000
    end
  end

  def trim
    lambda do |record, accumulator|
      accumulator.each {|x| x.strip!}
    end
  end

  def get_xml options={}
    lambda do |record, accumulator|
      accumulator << MARC::FastXMLWriter.encode(record)
    end
  end
end
