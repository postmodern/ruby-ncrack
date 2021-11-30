require 'ncrack/xml/service'

require 'nokogiri'

module Ncrack
  #
  # Represents an ncrack XML file or XML data.
  #
  class XML

    # The parsed XML document.
    #
    # @return [Nokogiri::XML::Node]
    #
    # @api private
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
    # @api private
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
    # @api public
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
    # @api public
    #
    def self.open(path)
      path = File.expand_path(path)

      new(Nokogiri::XML(File.open(path)), path: path)
    end

    #
    # The scanner that produced the XML (aka `ncrack`).
    #
    # @return [String]
    #   The value of the `scanner` attribute.
    #
    def scanner
      @scanner ||= @doc.root['scanner']
    end

    #
    # Additional command-line arguments passed to `ncrack`.
    #
    # @return [String]
    #   The value of the `args` attribute.
    #
    def args
      @args ||= @doc.root['args']
    end

    #
    # The start time.
    #
    # @return [Time]
    #   The parsed value of the `start` attribute.
    #
    def start
      @start ||= Time.at(@doc.root['start'].to_i)
    end

    #
    # The version of `ncrack`.
    #
    # @return [String]
    #   The value of the `version` attribute.
    #
    def version
      @version ||= @doc.root['version']
    end

    #
    # The version of the `ncrack` XML schema.
    #
    # @return [String]
    #   The value of the `xmloutputversion` attribute.
    #
    def xml_output_version
      @xml_output_version ||= @doc.root['xmloutputversion']
    end

    #
    # The verbosity level.
    #
    # @return [Integer]
    #   The parsed value of the `level` attribute of the  `verbose` child
    #   element.
    #
    def verbose
      @verbose ||= @doc.at_xpath('/ncrackrun/verbose')['level'].to_i
    end

    #
    # The debugging level.
    #
    # @return [Integer]
    #   The parsed value of the `level` attribute of the `debugging` child
    #   element.
    #
    def debugging
      @debugging ||= @doc.at_xpath('/ncrackrun/debugging')['level'].to_i
    end

    #
    # Enumerates over every service.
    #
    # @yield [service]
    #   If a block is given, it will be passed every service object.
    #
    # @yieldparam [Service] service
    #   A service object.
    #
    # @return [Enumerator]
    #   If no block is given, an Enumerator object will be returned.
    #
    def each_service
      return enum_for(__method__) unless block_given?

      @doc.root.xpath('/ncrackrun/service').each do |node|
        yield Service.new(node)
      end
    end

    #
    # All service object.
    #
    # @return [Array<Service>]
    #
    def services
      each_service.to_a
    end

    #
    # The first service object.
    #
    # @return [Service, nik]
    #
    def service
      each_service.first
    end

    #
    # Converts the XML to a String.
    #
    # @return [String]
    #   The path to the XML if {#path} is set, or the XML if the XML was parsed
    #   from a String.
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
