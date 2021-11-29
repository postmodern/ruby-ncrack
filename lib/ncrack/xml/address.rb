module Ncrack
  class XML
    class Address

      #
      # @param [Nokogiri::XML::Node] node
      #
      def initialize(node)
        @node = node
      end

      #
      # @return [String]
      #
      def addr
        @addr ||= @node['addr']
      end

      TYPES = {
        'ipv4' => :ipv4,
        'ipv6' => :ipv6
      }

      #
      # @return [:ipv4, :ipv6, String]
      #
      def type
        @type ||= (
          addrtype = @node['addrtype']
          TYPES.fetch(addrtype,addrtype)
        )
      end

      #
      # @return [Boolean]
      #
      def ipv4?
        type == :ipv4
      end

      #
      # @return [Boolean]
      #
      def ipv6
        type == :ipv6
      end

      #
      # @return [String]
      #
      def to_s
        addr.to_s
      end

    end
  end
end
