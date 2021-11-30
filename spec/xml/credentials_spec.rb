require 'spec_helper'
require 'ncrack/xml/credentials'
require 'nokogiri'

describe Ncrack::XML::Credentials do
  let(:fixtures_dir) { File.expand_path(File.join(__dir__,'..','fixtures')) }
  let(:path) { File.join(fixtures_dir,'ncrack.xml') }
  let(:xml)  { File.read(path) }
  let(:doc)  { Nokogiri::XML(File.open(path)) }
  let(:node) { doc.at_xpath('/ncrackrun/service/credentials') }

  subject { described_class.new(node) }

  describe "#username" do
    subject { super().username }

    it "must return the 'username' attribute" do
      expect(subject).to eq(node['username'])
    end
  end

  describe "#password" do
    subject { super().password }

    it "must return the 'password' attribute" do
      expect(subject).to eq(node['password'])
    end
  end

  describe "#to_s" do
    it "must return the 'username:password'" do
      expect(subject.to_s).to eq("#{subject.username}:#{subject.password}")
    end
  end

  describe "#to_a" do
    it "must return [username, password] tuple" do
      expect(subject.to_a).to eq([subject.username, subject.password])
    end
  end
end
