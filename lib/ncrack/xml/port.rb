module Ncrack
  class XML
    #
    # Represents a `port` XML element.
    #
    class Port

      #
      # Initializes the port object.
      #
      # @param [Nokogiri::XML::Node] node
      #   The XML node for the `port` XML element.
      #
      # @api private
      #
      def initialize(node)
        @node = node
      end

      # Mapping of the `protocol` attribute values to Symbols.
      PROTOCOLS = {
        'tcp' => :tcp,
        'udp' => :udp
      }

      #
      # The protocol of the port.
      #
      # @return [:tcp, :udp, String]
      #   The value of the `protocol` attribute.
      #
      def protocol
        @protocl ||= (
          protocol = @node['protocol']

          PROTOCOLS.fetch(protocol,protocol)
        )
      end

      #
      # The port number.
      #
      # @return [Integer]
      #   The parsed value of the `portid` attribute.
      #
      def number
        @number ||= @node['portid'].to_i
      end

      #
      # The name associated with the port.
      #
      # @return [String]
      #   The value of the `name` attribute.
      #
      def name
        @name ||= @node['name']
      end

      #
      # Converts the port to an Integer.
      #
      # @return [Integer]
      #   Returns the {#number}.
      #
      def to_i
        number.to_i
      end

      #
      # Converts the port to a String.
      #
      # @return [String]
      #   Returns the {#name}.
      #
      def to_s
        name.to_s
      end

    end
  end
end
