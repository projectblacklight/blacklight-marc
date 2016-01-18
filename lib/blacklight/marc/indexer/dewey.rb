module Blacklight::Marc::Indexer::Dewey
  def dewey_facets(options={})
    translation_map = (options[:translation_map] || "callnumber_map")
    unless translation_map.is_a? Traject::TranslationMap
      translation_map = Traject::TranslationMap.new(translation_map)
    end
    base = options[:base] || :hundreds
    lambda do |record, accumulator, context|
      vals = []
      extractor = Traject::MarcExtractor.new('082a', options)
      vals = extractor.extract(record).select{|v| valid_dewey? v}.collect do |val|
        if base == :hundreds
          c = val[0...1] + '00'
        elsif base == :tens
          c = val[0...2] + '0'
        end
        translation_map[c]
      end
      accumulator.concat vals
    end
  end
  def dewey_text(options={})
    lambda do |record, accumulator, context|
      vals = []
      extractor = Traject::MarcExtractor.new('082a', options)
      vals = extractor.extract(record).select{|v| valid_dewey? v}.collect do |val|
        val.gsub(/\/[.]/,'.').gsub('/',' ')
      end
      accumulator.concat vals unless vals.empty?
    end
  end
  def valid_dewey?(value)
    value =~ /^\d{1,3}(\.\d+)?.*/
  end
end