# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

require "rake"
describe "solr:marc:*" do
    # saves original $stdout in variable
    # set $stdout as local instance of StringIO
    # yields to code execution
    # returns the local instance of StringIO
    # resets $stout to original value
    def capture_stdout
      out = StringIO.new
      $stdout = out
      yield
      return out.string
    ensure
      $stdout = STDOUT
    end

    before(:all) do
      @rake = Rake::Application.new
      Rake.application = @rake
      Rake.application.rake_require "../lib/railties/solr_marc"
      Rake::Task.define_task(:environment)
    end

    describe 'solr:marc:index_test_data' do
      it 'should print out usage using NOOP=true' do
        root = Rails.root
        ENV['NOOP'] = "true"
        o = capture_stdout do
          @rake['solr:marc:index_test_data'].invoke
        end

        expect(o).to match(Regexp.escape("Possible environment variables, with settings as invoked"))
      end
    end

    describe "solr:marc:index" do
      after do
        SolrMarc.indexer= nil
      end
      it "should index the test data configured" do
        indexer = double(MarcIndexer)
        allow(indexer).to receive(:process).with("dummy.mrc")
        SolrMarc.indexer= indexer
        #expect(indexer).to receive(:process).with("dummy.mrc")
        ENV["MARC_FILE"] = "dummy.mrc"
        output = capture_stdout do
          @rake['solr:marc:index:work'].invoke
        end
      end

    end
  end

