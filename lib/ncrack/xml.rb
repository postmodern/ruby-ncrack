require 'ncrack/xml/service'

require 'nokogiri'

module Ncrack
  class XML

    # The parsed XML document.
    #
    # @return [Nokogiri::XML::Node]
    attr_reader :doc

    # The path to the XML file.
    #
    # @return [String, nil]
    attr_reader :path

    #
    # Creates a new XML object.
    #
    # @param [Nokogiri::XML] doc
    #   The parsed XML document.
    #
    # @param [String, nil] path
    #   The path to the XML file.
    #
    # @yield [xml]
    #   If a block is given, it will be passed the newly created XML
    #   parser.
    #
    # @yieldparam [XML] xml
    #   The newly created XML parser.
    #
    def initialize(doc, path: nil)
      @doc  = doc
      @path = File.expand_path(path) if path

      yield self if block_given?
    end

    #
    # Parses the given XML String.
    #
    # @param [String] xml
    #   The XML String.
    #
    # @return [XML]
    #   The parsed XML.
    #
    def self.parse(xml)
      new(Nokogiri::XML(xml))
    end

    #
    # Opens an parses an XML file.
    #
    # @param [String] path
    #   The path to the XML file.
    #
    # @return [XML]
    #   The parsed XML.
    #
    def self.open(path)
      path = File.expand_path(path)

      new(Nokogiri::XML(File.open(path)), path: path)
    end

    #
    # @return [String]
    #
    def scanner
      @scanner ||= @doc.root['scanner']
    end

    #
    # @return [String]
    #
    def args
      @args ||= @doc.root['args']
    end

    #
    # @return [Time]
    #
    def start
      @start ||= Time.at(@doc.root['start'].to_i)
    end

    #
    # @return [String]
    #
    def version
      @version ||= @doc.root['version']
    end

    #
    # @return [String]
    #
    def xml_output_version
      @xml_output_version ||= @doc.root['xmloutputversion']
    end

    #
    # @return [Integer]
    #
    def verbose
      @verbose ||= @doc.at_xpath('/ncrackrun/verbose')['level'].to_i
    end

    #
    # @return [Integer]
    #
    def debugging
      @debugging ||= @doc.at_xpath('/ncrackrun/debugging')['level'].to_i
    end

    #
    # @yield [service]
    #
    # @yieldparam [Service] service
    #
    # @return [Enumerator]
    #
    def each_service
      return enum_for(__method__) unless block_given?

      @doc.root.xpath('/ncrackrun/service').each do |node|
        yield Service.new(node)
      end
    end

    #
    # @return [Array<Service>]
    #
    def services
      each_service.to_a
    end

    #
    # @return [Service, nik]
    #
    def service
      each_service.first
    end

    #
    # @return [String]
    #
    def to_s
      if @path
        @path
      else
        @doc.to_s
      end
    end

  end
end
