require 'spec_helper'
require 'ncrack/xml/address'
require 'nokogiri'

describe Ncrack::XML::Address do
  let(:fixtures_dir) { File.expand_path(File.join(__dir__,'..','fixtures')) }
  let(:path) { File.join(fixtures_dir,'ncrack.xml') }
  let(:xml)  { File.read(path) }
  let(:doc)  { Nokogiri::XML(File.open(path)) }
  let(:node) { doc.at_xpath('/ncrackrun/service/address') }

  subject { described_class.new(node) }

  describe "#addr" do
    subject { super().addr }

    it "must return a String" do
      expect(subject).to be_kind_of(String)
    end

    it "must return the 'addr' attribute" do
      expect(subject).to eq(node['addr'])
    end
  end

  describe "#type" do
    it "must return the 'addrtype' attribute as a Symbol" do
      expect(subject.type).to eq(node['addrtype'].to_sym)
    end
  end

  describe "#ipv4?" do
    context "when #type returns :ipv4" do
      before { allow(subject).to receive(:type).and_return(:ipv4) }

      it "must return true" do
        expect(subject.ipv4?).to be(true)
      end
    end

    context "when #type does not return :ipv4" do
      before { allow(subject).to receive(:type).and_return(:ipv6) }

      it "must return false" do
        expect(subject.ipv4?).to be(false)
      end
    end
  end

  describe "#ipv6?" do
    context "when #type returns :ipv6" do
      before { allow(subject).to receive(:type).and_return(:ipv6) }

      it "must return true" do
        expect(subject.ipv6?).to be(true)
      end
    end

    context "when #type does not return :ipv6" do
      before { allow(subject).to receive(:type).and_return(:ipv4) }

      it "must return false" do
        expect(subject.ipv6?).to be(false)
      end
    end
  end

  describe "#to_s" do
    it "must return #addr" do
      expect(subject.to_s).to eq(subject.addr)
    end
  end
end
