require 'spec_helper'
require 'ncrack/xml/port'
require 'nokogiri'

describe Ncrack::XML::Port do
  let(:fixtures_dir) { File.expand_path(File.join(__dir__,'..','fixtures')) }
  let(:path) { File.join(fixtures_dir,'ncrack.xml') }
  let(:xml)  { File.read(path) }
  let(:doc)  { Nokogiri::XML(File.open(path)) }
  let(:node) { doc.at_xpath('/ncrackrun/service/port') }

  subject { described_class.new(node) }

  describe "#protocol" do
    subject { super().protocol }

    it "must return the 'protocol' attribute as a Symbol" do
      expect(subject).to eq(node['protocol'].to_sym)
    end
  end

  describe "#number" do
    subject { super().number }

    it "must return the 'portid' attribute as an Integer" do
      expect(subject).to eq(node['portid'].to_i)
    end
  end

  describe "#name" do
    subject { super().name }

    it "must return a String" do
      expect(subject).to be_kind_of(String)
    end

    it "must return the 'name' attribute" do
      expect(subject).to eq(node['name'])
    end
  end

  describe "#to_i" do
    it "must return #number" do
      expect(subject.to_i).to eq(subject.number)
    end
  end

  describe "#to_s" do
    it "must return the #name" do
      expect(subject.to_s).to eq(subject.name)
    end
  end
end
