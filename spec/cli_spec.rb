require 'spec_helper'
require 'fileutils'

describe GemfileUtils::Cli::Base do

  let(:fixture_gemfile_path){
    File.expand_path('../../spec/fixtures', __FILE__)
  }

  let(:gemfile_fixture){
    "#{fixture_gemfile_path}/Gemfile"
  }

  let(:expected_gemfile){
    "#{fixture_gemfile_path}/result/Gemfile"
  }

  before do
    FileUtils.cp("#{fixture_gemfile_path}/initial/Gemfile", gemfile_fixture)
  end

  after do
    FileUtils.rm(gemfile_fixture)
  end

  let(:comments!){
    ["some_name", "--test-framework", "rspec"]
    described_class.start(['comments', "--gemfile", gemfile_fixture, "--licenses", 'true',  "--homepage", 'true' ])
  }

  let(:licenses!){
    described_class.start(['licenses', "--gemfile", gemfile_fixture])
  }

  subject do
    VCR.use_cassette("rubygems") do
      comments!
      licenses!
    end
  end

  it 'should change Gemfile' do
    subject
    expect(File.readlines(gemfile_fixture)).to eq(File.readlines(expected_gemfile))
  end

end