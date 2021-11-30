require 'ncrack/xml/address'
require 'ncrack/xml/port'
require 'ncrack/xml/credentials'

module Ncrack
  class XML
    #
    # Represents a `service` XML element.
    #
    class Service

      #
      # Initializes the service object.
      #
      # @param [Nokogiri::XML::Node] node
      #   The XML node for the `service` XML element.
      #
      def initialize(node)
        @node = node
      end

      #
      # When bruteforcing of the service begin.
      #
      # @return [Time]
      #   The parsed value of the `starttime` attribute.
      #
      def start_time
        @start_time ||= Time.at(@node['starttime'].to_i)
      end

      #
      # When bruteforcing of the service stopped.
      #
      # @return [Time]
      #   The parsed value of the `endtime` attribute.
      #
      def end_time
        @end_time ||= Time.at(@node['endtime'].to_i)
      end

      #
      # The address information of the service.
      #
      # @return [Address]
      #   The `address` XML child element.
      #
      def address
        @address ||= Address.new(@node.at_xpath('address'))
      end

      #
      # The port information of the service.
      #
      # @return [Port]
      #   The `port` XML child element.
      #
      def port
        @port ||= Port.new(@node.at_xpath('port'))
      end

      #
      # Enumerates over every bruteforced credential.
      #
      # @yield [credential]
      #   If a block is given it will be passed each bruteforced credential.
      #
      # @yieldparam [Credential] credential
      #   A bruteforced credential.
      #
      # @return [Enumerator]
      #   If no block is given, an Enumerator will be returned.
      #
      def each_credentials
        return enum_for(__method__) unless block_given?

        @node.xpath('credentials').each do |node|
          yield Credentials.new(node)
        end
      end

      #
      # The bruteforced credentials.
      #
      # @return [Array<Credential>]
      #
      def credentials
        each_credentials.to_a
      end

      #
      # The first bruteforced credential.
      #
      # @return [Credential, nil]
      #
      def credential
        each_credentials.first
      end

    end
  end
end
