module Ncrack
  class XML
    #
    # Represents a `address` XML element.
    #
    class Address

      #
      # Initializes the address object.
      #
      # @param [Nokogiri::XML::Node] node
      #   The XML node for the `address` XML element.
      #
      # @api private
      #
      def initialize(node)
        @node = node
      end

      #
      # The IP of the address.
      #
      # @return [String]
      #   The value of the `addr` attribute.
      #
      def addr
        @addr ||= @node['addr']
      end

      # Mapping of `addrtype` values to Symbols.
      TYPES = {
        'ipv4' => :ipv4,
        'ipv6' => :ipv6
      }

      #
      # The IP address type.
      #
      # @return [:ipv4, :ipv6, String]
      #   The value of the `addrtype` attribute.
      #
      def type
        @type ||= (
          addrtype = @node['addrtype']
          TYPES.fetch(addrtype,addrtype)
        )
      end

      #
      # Determines whether the address is IPv4 or IPv6.
      #
      # @return [Boolean]
      #
      def ipv4?
        type == :ipv4
      end

      #
      # Determines whether the address is IPv6 or IPv4.
      #
      # @return [Boolean]
      #
      def ipv6?
        type == :ipv6
      end

      #
      # Converts the address to a String.
      #
      # @return [String]
      #   The IP of the address.
      #
      def to_s
        addr.to_s
      end

    end
  end
end
