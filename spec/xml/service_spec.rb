require 'spec_helper'
require 'ncrack/xml/service'
require 'nokogiri'

describe Ncrack::XML::Service do
  let(:fixtures_dir) { File.expand_path(File.join(__dir__,'..','fixtures')) }
  let(:path) { File.join(fixtures_dir,'ncrack.xml') }
  let(:xml)  { File.read(path) }
  let(:doc)  { Nokogiri::XML(File.open(path)) }
  let(:node) { doc.at_xpath('/ncrackrun/service') }

  subject { described_class.new(node) }

  describe "#start_time" do
    subject { super().start_time }

    it "must return the 'starttime' attribute as a Time object" do
      expect(subject).to eq(Time.at(node['starttime'].to_i))
    end
  end

  describe "#end_time" do
    subject { super().end_time }

    it "must return the 'endtime' attribute as a Time object" do
      expect(subject).to eq(Time.at(node['endtime'].to_i))
    end
  end

  describe "#address" do
    subject { super().address }

    it "must return an Ncrack::XML::Address object" do
      expect(subject).to be_kind_of(Ncrack::XML::Address)
    end
  end

  describe "#port" do
    subject { super().port }

    it "must return an Ncrack::XML::Port object" do
      expect(subject).to be_kind_of(Ncrack::XML::Port)
    end
  end

  let(:credentials_count) { node.xpath('credentials').count }

  describe "#each_credentials" do
    context "when given a block" do
      it "must yield each Nikto::XML::Credentials object" do
        expect { |b|
          subject.each_credentials(&b)
        }.to yield_successive_args(*Array.new(credentials_count,Ncrack::XML::Credentials))
      end
    end

    context "when no block is given" do
      subject { super().each_credentials.to_a }

      it "must return an Enumerator of Ncrack::XML::Credentials objects" do
        expect(subject.length).to be(credentials_count)
        expect(subject).to all(be_kind_of(Ncrack::XML::Credentials))
      end
    end
  end

  describe "#credentials" do
    subject { super().credentials }

    it "must return an Array of #{described_class}::Service" do
      expect(subject).to be_kind_of(Array)
      expect(subject.length).to be(credentials_count)
      expect(subject).to all(be_kind_of(Ncrack::XML::Credentials))
    end
  end

  describe "#credential" do
    let(:first_credentials) { subject.credentials.first }
    let(:credential)        { subject.credential }

    it "must return the first #credentials" do
      expect(credential.username).to eq(first_credentials.username)
      expect(credential.password).to eq(first_credentials.password)
    end
  end
end
