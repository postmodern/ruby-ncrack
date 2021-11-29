module Ncrack
  class XML
    class Port

      #
      # @param [Nokogiri::XML::Node] node
      #
      def initialize(node)
        @node = node
      end

      PROTOCLS = {
        'tcp' => :tcp,
        'udp' => :udp
      }

      #
      # @return [:tcp, :udp, String]
      #
      def protocol
        @protocl ||= (
          protocol = @node['protocol']
          PROTOCOLS.fetch(protocol,protocol)
        )
      end

      #
      # @return [Integer]
      #
      def number
        @number ||= @node['portid'].to_i
      end

      #
      # @return [String]
      #
      def name
        @name ||= @node['name']
      end

      #
      # @return [Integer]
      #
      def to_i
        number.to_i
      end

      #
      # @return [String]
      #
      def to_s
        name.to_s
      end

    end
  end
end
