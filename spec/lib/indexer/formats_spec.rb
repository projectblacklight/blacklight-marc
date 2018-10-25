# -*- encoding : utf-8 -*-
require 'spec_helper'
#require 'marc'
describe Blacklight::Marc::Indexer::Formats do
  let(:test_class) do
    c = Class.new(Blacklight::Marc::Indexer)
    c.send :include, Blacklight::Marc::Indexer::Formats
    c
  end

  subject {test_class.new}
  before do
    subject.instance_eval do
      to_field 'format', get_format
      settings do
        provide "writer_class_name", "Traject::JsonWriter"
      end
    end
  end

  describe '#get_format' do
    let(:electronic) do
      MARC::DataField.new('245',' ',' ',['h','electronic resource'])
    end
    it 'should respond' do
      expect(subject).to respond_to(:get_format)
    end
    it 'should map for 245h fields' do
      record = double('Record')
      # just return bytes for control field, subfield array for data
      expect(record).to receive(:fields).with(['245','880']).and_return([electronic])
      val = []
      subject.get_format.call(record,val,subject)
      expect(val).to eql(['Electronic'])
    end
    it 'should map for 007 fields' do
      record = double('Record')
      allow(record).to receive(:fields).with(["245", "880"]).and_return([])
      expect(record).to receive(:fields).with(["007", "880"]).and_return([MARC::ControlField.new('007','CA')])
      val = []
      subject.get_format.call(record,val,subject)
      expect(val).to eql(['TapeCartridge'])
    end
    it 'should map for 007 field with AD value' do
      record = double('Record')
      allow(record).to receive(:fields).with(["245", "880"]).and_return([])
      expect(record).to receive(:fields).with(["007", "880"]).and_return([MARC::ControlField.new('007','AD')])
      val = []
      subject.get_format.call(record,val,subject)
      expect(val).to eql(['Atlas'])
    end
    it 'should map for leader' do
      record = double('Record')
      allow(record).to receive(:fields).with(["245", "880"]).and_return([])
      allow(record).to receive(:fields).with(["007", "880"]).and_return([])
      allow(record).to receive(:[]).with('001').and_return(MARC::ControlField.new('001',''))
      expect(record).to receive(:leader).and_return('012345am')
      val = []
      subject.get_format.call(record,val,subject)
      expect(val).to eql(['Book'])
    end
    it 'should default' do
      record = double('Record')
      allow(record).to receive(:fields).with(["245", "880"]).and_return([])
      allow(record).to receive(:fields).with(["007", "880"]).and_return([])
      allow(record).to receive(:[]).with('001').and_return(MARC::ControlField.new('001',''))
      allow(record).to receive(:leader).and_return('012345##')
      val = []
      subject.get_format.call(record,val,subject)
      expect(val).to eql(['Unknown'])
    end
  end
end
