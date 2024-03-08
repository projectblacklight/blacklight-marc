require 'spec_helper'

class MockClass260
  include Blacklight::Marc::DocumentExport

  def to_marc
    fields = [
      { "100" => { "subfields" => [{ "a" => "Borja, Ronaldo I." }]}},
      { "245" => { "ind1" => " ", "ind2" => " ", "subfields" => [{ "a" => "Plasticity : ", "b" => "modeling & computation /", "c" => "Ronaldo I. Borja." }] } },
      { "260" => { "ind1" => " ", "ind2" => " ", "subfields" => [{ "a" => "Berlin :", "b" => "Springer,", "c" => "[2013]" }] } }
    ]
    MARC::Record.new_from_hash('fields' => fields)
  end
end

class MockClass264
  include Blacklight::Marc::DocumentExport

  def to_marc
    fields = [
      { "100" => { "subfields" => [{ "a" => "Borja, Ronaldo I." }]}},
      { "245" => { "ind1" => " ", "ind2" => " ", "subfields" => [{ "a" => "Plasticity : ", "b" => "modeling & computation /", "c" => "Ronaldo I. Borja." }] } },
      { "264" => { "ind1" => " ", "ind2" => " ", "subfields" => [{ "a" => "Berlin :", "b" => "Springer,", "c" => "[2013]" }] } }
    ]
    MARC::Record.new_from_hash('fields' => fields)
  end
end

class MockClassInvalid700
  include Blacklight::Marc::DocumentExport

  def to_marc
    fields = [
      { "100" => { "subfields" => [{ "a" => "Borja, Ronaldo I." }]}},
      { "245" => { "ind1" => " ", "ind2" => " ", "subfields" => [{ "a" => "Plasticity : ", "b" => "modeling & computation /", "c" => "Ronaldo I. Borja." }] } },
      { "700" => { "ind1" => " ", "ind2" => " ", "subfields" => [{ "a" => ", ." }] } }
    ]
    MARC::Record.new_from_hash('fields' => fields)
  end
end

RSpec.describe Blacklight::Marc::DocumentExport do
  describe 'export citiations from 260 field' do
    it 'exports citations in apa format' do
      expect(MockClass260.new.export_as_apa_citation_txt).to include('(2013)')
      expect(MockClass260.new.export_as_apa_citation_txt).to include('Berlin: Springer.')
    end

    it 'exports citations in mla format' do
      expect(MockClass260.new.export_as_mla_citation_txt).to include('2013.')
      expect(MockClass260.new.export_as_mla_citation_txt).to include('Berlin: Springer,')
    end

    it 'exports citations in Chicago format' do
      expect(MockClass260.new.export_as_chicago_citation_txt).to include('2013.')
      expect(MockClass260.new.export_as_chicago_citation_txt).to include('Berlin: Springer,')
    end
  end

  describe 'export citations from 264 field' do
    it 'exports citations in apa format' do
      expect(MockClass264.new.export_as_apa_citation_txt).to include('(2013)')
      expect(MockClass264.new.export_as_apa_citation_txt).to include('Berlin: Springer.')
    end

    it 'exports citations in mla format' do
      expect(MockClass264.new.export_as_mla_citation_txt).to include('2013.')
      expect(MockClass264.new.export_as_mla_citation_txt).to include('Berlin: Springer,')
    end

    it 'exports citations in Chicago format' do
      expect(MockClass264.new.export_as_chicago_citation_txt).to include('2013.')
      expect(MockClass264.new.export_as_chicago_citation_txt).to include('Berlin: Springer,')
    end
  end

  describe 'when the 700 only has punctuation and spaces' do
    it 'exports citations in apa format' do
      expect(MockClassInvalid700.new.export_as_apa_citation_txt).to include('Borja, R. I')
      expect(MockClassInvalid700.new.export_as_apa_citation_txt).to include('Plasticity')
    end

    it 'exports citations in mla format' do
      expect(MockClassInvalid700.new.export_as_mla_citation_txt).to include('Borja, Ronaldo I')
      expect(MockClassInvalid700.new.export_as_mla_citation_txt).to include('Plasticity')
    end

    it 'exports citations in Chicago format' do
      expect(MockClassInvalid700.new.export_as_chicago_citation_txt).to include('Borja, Ronaldo I')
      expect(MockClassInvalid700.new.export_as_chicago_citation_txt).to include('Plasticity')
    end
  end
end
