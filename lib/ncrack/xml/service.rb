require 'ncrack/xml/address'
require 'ncrack/xml/port'
require 'ncrack/xml/credentials'

module Ncrack
  class XML
    class Service

      #
      # @param [Nokogiri::XML::Node] node
      #
      def initialize(node)
        @node = node
      end

      #
      # @return [Time]
      #
      def start_time
        @start_time ||= Time.at(@node['starttime'])
      end

      #
      # @return [Time]
      #
      def end_time
        @end_time ||= Time.at(@node['endtime'])
      end

      #
      # @return [Address]
      #
      def address
        @address ||= Address.new(@node.xpath('address'))
      end

      #
      # @return [Port]
      #
      def port
        @port ||= Port.new(@node.xpath('port'))
      end

      #
      # @yield [credential]
      #
      # @yieldparam [Credential] credential
      #
      # @return [Enumerator]
      #
      def each_credential
        return enum_for(__method__) unless block_given?

        @node.xpath('credentials').each do |node|
          yield Credential.new(node)
        end
      end

      #
      # @return [Array<Credential>]
      #
      def credentials
        each_credential.to_a
      end

    end
  end
end
