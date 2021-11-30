require 'spec_helper'
require 'ncrack/xml'

describe Ncrack::XML do
  let(:fixtures_dir) { File.expand_path(File.join(__dir__,'fixtures')) }
  let(:path) { File.join(fixtures_dir,'ncrack.xml') }
  let(:xml) { File.read(path) }
  let(:doc) { Nokogiri::XML(File.open(path)) }

  subject { described_class.new(doc, path: path) }

  describe "#initialize" do
    it "must set #doc" do
      expect(subject.doc).to eq(doc)
    end

    context "when given a block" do
      it "must yield the new XML object" do
        expect { |b|
          described_class.new(xml,&b)
        }.to yield_with_args(described_class)
      end
    end

    context "when the path: keyword argument is not given" do
      subject { described_class.new(xml) }

      it "must set #path to nil" do
        expect(subject.path).to be(nil)
      end
    end

    context "when the path: keyword argument is given" do
      subject { described_class.new(xml, path: path) }

      it "must set #path" do
        expect(subject.path).to eq(path)
      end
    end
  end

  describe ".parse" do
    subject { described_class.parse(xml) }

    it "must parse the XML data" do
      expect(subject.doc).to be_kind_of(Nokogiri::XML::Document)
    end

    it "must set #path to nil" do
      expect(subject.path).to be(nil)
    end
  end

  describe ".open" do
    subject { described_class.open(path) }

    it "must open the file and parse the XML" do
      expect(subject.doc).to be_kind_of(Nokogiri::XML::Document)
    end

    it "must set #path" do
      expect(subject.path).to eq(path)
    end
  end

  describe "#scanner" do
    subject { super().scanner }

    it "must return the 'scanner' attribute" do
      expect(subject).to eq(doc.root['scanner'])
    end
  end

  describe "#args" do
    subject { super().args }

    it "must return the 'args' attribute" do
      expect(subject).to eq(doc.root['args'])
    end
  end

  describe "#start" do
    subject { super().start }

    it "must return the 'start' attribute as a Time object" do
      expect(subject).to eq(Time.at(doc.root['start'].to_i))
    end
  end

  describe "#version" do
    subject { super().version }

    it "must return the 'version' attribute" do
      expect(subject).to eq(doc.root['version'])
    end
  end

  describe "#xml_output_version" do
    subject { super().xml_output_version }

    it "must return the 'xmloutputversion' attribute" do
      expect(subject).to eq(doc.root['xmloutputversion'])
    end
  end

  describe "#verbose" do
    subject { super().verbose }

    it "must return the 'level' attribute of the 'verbose' child element as an Integer" do
      expect(subject).to eq(doc.root.at_xpath('verbose')['level'].to_i)
    end

    it "must be > 0" do
      expect(subject).to be > 0
    end
  end

  describe "#debugging" do
    subject { super().debugging }

    it "must return the 'level' attribute of the 'debugging' child element as an Integer" do
      expect(subject).to eq(doc.root.at_xpath('debugging')['level'].to_i)
    end
  end

  let(:services_count) { doc.root.xpath('/ncrackrun/service').count }

  describe "#each_service" do
    context "when given a block" do
      it "must yield each Service object" do
        expect { |b|
          subject.each_service(&b)
        }.to yield_successive_args(*Array.new(services_count,described_class::Service))
      end
    end

    context "when no block is given" do
      subject { super().each_service.to_a }

      it "must return an Enumerator of #{described_class}::Service objects" do
        expect(subject.length).to be(services_count)
        expect(subject).to all(be_kind_of(described_class::Service))
      end
    end
  end

  describe "#services" do
    subject { super().services }

    it "must return an Array of #{described_class}::Service" do
      expect(subject).to be_kind_of(Array)
      expect(subject.length).to be(services_count)
      expect(subject).to all(be_kind_of(described_class::Service))
    end
  end

  describe "#service" do
    let(:first_service) { subject.services.first }
    let(:service)       { subject.service }

    it "must return the first #scan_details" do
      expect(service.start_time).to eq(first_service.start_time)
      expect(service.end_time).to eq(first_service.end_time)
    end
  end

  describe "#to_s" do
    context "when #path is set" do
      subject { described_class.open(path) }

      it "must return the #path" do
        expect(subject.to_s).to eq(path)
      end
    end

    context "when #path is nil" do
      subject { described_class.parse(xml) }

      it "must return the XML" do
        expect(subject.to_s).to eq(doc.to_s)
      end
    end
  end
end
