module Ncrack
  class XML
    class Credentials

      #
      # @param [Nokogiri::XML::Node] node
      #
      def initialize(node)
        @node = node
      end

      #
      # @return [String]
      #
      def username
        @username ||= @node['username']
      end

      #
      # @return [String]
      #
      def password
        @password ||= @node['password']
      end

      #
      # @return [String]
      #
      def to_s
        "#{username}:#{password}"
      end

      #
      # @return [(String, String)]
      #
      def to_a
        [username, password]
      end

    end
  end
end
