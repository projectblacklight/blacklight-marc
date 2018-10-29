# -*- encoding : utf-8 -*-
require 'spec_helper'
def music_record
"<collection xmlns=\"http://www.loc.gov/MARC21/slim\">
<record>
  <leader>01828cjm a2200409 a 4500</leader>
  <controlfield tag=\"001\">a4768316</controlfield>
  <controlfield tag=\"003\">SIRSI</controlfield>
  <controlfield tag=\"007\">sd fungnnmmned</controlfield>
  <controlfield tag=\"008\">020117p20011990xxuzz    h              d</controlfield>

  <datafield tag=\"245\" ind1=\"0\" ind2=\"0\">
    <subfield code=\"a\">Music for horn</subfield>
    <subfield code=\"h\">[sound recording] /</subfield>
    <subfield code=\"c\">Brahms, Beethoven, von Krufft.</subfield>
  </datafield>

  <datafield tag=\"260\" ind1=\" \" ind2=\" \">
    <subfield code=\"a\">[United States] :</subfield>
    <subfield code=\"b\">Harmonia Mundi USA,</subfield>
    <subfield code=\"c\">p2001.</subfield>
  </datafield>

  <datafield tag=\"700\" ind1=\"1\" ind2=\" \">
    <subfield code=\"a\">Greer, Lowell.</subfield>
  </datafield>

  <datafield tag=\"700\" ind1=\"1\" ind2=\" \">
    <subfield code=\"a\">Lubin, Steven.</subfield>
  </datafield>

  <datafield tag=\"700\" ind1=\"1\" ind2=\" \">
    <subfield code=\"a\">Chase, Stephanie,</subfield>
    <subfield code=\"d\">1957-</subfield>
  </datafield>

  <datafield tag=\"700\" ind1=\"1\" ind2=\"2\">
    <subfield code=\"a\">Brahms, Johannes,</subfield>
    <subfield code=\"d\">1833-1897.</subfield>
    <subfield code=\"t\">Trios,</subfield>
    <subfield code=\"m\">piano, violin, horn,</subfield>
    <subfield code=\"n\">op. 40,</subfield>
    <subfield code=\"r\">E? major.</subfield>
  </datafield>

  <datafield tag=\"700\" ind1=\"1\" ind2=\"2\">
    <subfield code=\"a\">Beethoven, Ludwig van,</subfield>
    <subfield code=\"d\">1770-1827.</subfield>
    <subfield code=\"t\">Sonatas,</subfield>
    <subfield code=\"m\">horn, piano,</subfield>
    <subfield code=\"n\">op. 17,</subfield>
    <subfield code=\"r\">F major.</subfield>
  </datafield>

  <datafield tag=\"700\" ind1=\"1\" ind2=\"2\">
    <subfield code=\"a\">Krufft, Nikolaus von,</subfield>
    <subfield code=\"d\">1779-1818.</subfield>
    <subfield code=\"t\">Sonata,</subfield>
    <subfield code=\"m\">horn, piano,</subfield>
    <subfield code=\"r\">F major.</subfield>
  </datafield>
</record>
</collection>"
end
module TestIndexer
  def initialize
    super
    settings do
      # have to override the defaults!
      store "marc_source.type", "xml"
      store "writer_class_name", "TestIndexer::Writer"
    end
    to_field "id", extract_marc("001"), first_only, trim
    to_field "format", extract_marc('007[0-1]') do |rec, acc|
      legacy_formats = Traject::TranslationMap.new("test_formats")
      acc << rec.leader[6..7]
      acc << rec.leader[7]
      acc.map! {|x| legacy_formats[x]}
      acc.compact! # get rid of nils
      acc << 'Unknown' # the default
      acc.replace Array(acc[0]) # just take the first
    end
    to_field "mapped", literal('k'), translation_map("test_formats","test_dewey")
    to_field "mapped_second", literal('000'), translation_map("test_dewey","test_formats")
    to_field "mapped_third", literal('000'), translation_map("test_dewey")
  end
  class Writer
    def self.accumulator=(acc)
      @acc = acc
    end
    def self.accumulator
      @acc
    end
  attr_reader :settings

    def initialize(argSettings)
    end


    def serialize(context);end
    def close;end
    def put(context)
      puts context.output_hash.inspect
      TestIndexer::Writer.accumulator << context.output_hash
    end
  end
end

describe Blacklight::Marc::Indexer do
  before do
    $:.unshift './test_support/config'
  end
  subject { Blacklight::Marc::Indexer.new }
  it do
    expect(subject).to respond_to(:process)
  end
  context "XML indexing" do
    let(:test_class) do
      c = Class.new(Blacklight::Marc::Indexer)
      c.send :include, TestIndexer
    end
    subject {test_class.new}
    it do
      io = StringIO.new(music_record)
      vals = []
      TestIndexer::Writer.accumulator= vals
      subject.writer_class = TestIndexer::Writer
      subject.process(io)
      json = vals.first
      expect(json['format']).to eql(['Sound Disc'])
      expect(json['mapped']).to eql(['Image'])
      expect(json['mapped_second']).to eql(['Bad Metadata'])
      expect(json['mapped_third']).to eql(['000s - Computer Science, Information & General Works'])
    end
  end
end