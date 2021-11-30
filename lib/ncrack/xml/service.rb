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
        @start_time ||= Time.at(@node['starttime'].to_i)
      end

      #
      # @return [Time]
      #
      def end_time
        @end_time ||= Time.at(@node['endtime'].to_i)
      end

      #
      # @return [Address]
      #
      def address
        @address ||= Address.new(@node.at_xpath('address'))
      end

      #
      # @return [Port]
      #
      def port
        @port ||= Port.new(@node.at_xpath('port'))
      end

      #
      # @yield [credential]
      #
      # @yieldparam [Credential] credential
      #
      # @return [Enumerator]
      #
      def each_credentials
        return enum_for(__method__) unless block_given?

        @node.xpath('credentials').each do |node|
          yield Credentials.new(node)
        end
      end

      #
      # @return [Array<Credential>]
      #
      def credentials
        each_credentials.to_a
      end

      #
      # @return [Credential, nil]
      #
      def credential
        each_credentials.first
      end

    end
  end
end
