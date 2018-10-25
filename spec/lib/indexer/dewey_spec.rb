# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Blacklight::Marc::Indexer::Dewey do
  let(:test_class) do
    c = Class.new(Blacklight::Marc::Indexer)
    c.send :include, Blacklight::Marc::Indexer::Dewey
    c
  end
  subject {test_class.new}
  before do
    $:.unshift './test_support/config'
    subject.instance_eval do
      to_field 'dewey100', dewey_facets(base: :hundreds, translation_map: 'test_dewey')
      to_field 'dewey010', dewey_facets(base: :tens, translation_map: 'test_dewey')
      to_field 'dewey_text', dewey_text
      settings do
        store "writer_class_name", "Traject::JsonWriter"
      end
    end
  end
  let(:dewey) do
    MARC::DataField.new('082',' ',' ',['a','343/13'])
  end
  let(:huey) do
    MARC::DataField.new('082',' ',' ',['a','lol/wut'])
  end
  describe '#dewey_facets' do
    it do
      expect(subject).to respond_to(:dewey_facets)
    end
    it 'should map valid dewey' do
      record = double('Record')
      # just return bytes for control field, subfield array for data
      expect(record).to receive(:fields).with(['082','880']).exactly(2).times.and_return([dewey])
      val = []
      subject.dewey_facets(base: :hundreds, translation_map: 'test_dewey').call(record,val,subject)
      expect(val).to eql(['300s - Social Sciences'])
      val = []
      subject.dewey_facets(base: :tens, translation_map: 'test_dewey').call(record,val,subject)
      expect(val).to eql(['340s - Law'])
    end
    it 'should ignore invalid dewey' do
      record = double('Record')
      # just return bytes for control field, subfield array for data
      expect(record).to receive(:fields).with(['082','880']).exactly(2).times.and_return([huey])
      val = []
      subject.dewey_facets(base: :hundreds, translation_map: 'test_dewey').call(record,val,subject)
      expect(val).to eql([])
      val = []
      subject.dewey_facets(base: :tens, translation_map: 'test_dewey').call(record,val,subject)
      expect(val).to eql([])
    end
  end
  describe '#dewey_text' do
    it do
      expect(subject).to respond_to(:dewey_text)
    end
    it 'should generate formatted, unmapped text' do
      record = double('Record')
      # just return bytes for control field, subfield array for data
      expect(record).to receive(:fields).with(['082','880']).and_return([dewey])
      val = []
      subject.dewey_text.call(record,val,subject)
      expect(val).to eql(['343 13'])
    end
    it 'should ignore invalid dewey' do
      record = double('Record')
      # just return bytes for control field, subfield array for data
      expect(record).to receive(:fields).with(['082','880']).times.and_return([huey])
      val = []
      subject.dewey_text.call(record,val,subject)
      expect(val).to eql([])
    end
  end
  describe '#valid_dewey?' do
    it do
      expect(subject).to respond_to(:valid_dewey?)
    end
    it 'shoud audit values' do
      expect(subject.valid_dewey?'111.4').to be_truthy
      expect(subject.valid_dewey?'111.a').to be_truthy
      expect(subject.valid_dewey?'a11.4').to be_falsy
    end
  end
end
