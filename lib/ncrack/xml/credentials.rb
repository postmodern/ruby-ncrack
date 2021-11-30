module Ncrack
  class XML
    #
    # Represents a `credentials` XML element.
    #
    class Credentials

      #
      # Initializes the credentials object.
      #
      # @param [Nokogiri::XML::Node] node
      #   The XML node for the `credentials` XML element.
      #
      # @api private
      #
      def initialize(node)
        @node = node
      end

      #
      # The successfully bruteforced username.
      #
      # @return [String]
      #   The value of the `username` attribute.
      #
      def username
        @username ||= @node['username']
      end

      alias user_name username

      #
      # The successfully bruteforced password.
      #
      # @return [String]
      #   The value of the `password` attribute.
      #
      def password
        @password ||= @node['password']
      end

      #
      # Converts the credentials to a String.
      #
      # @return [String]
      #   Returns a `"username:password"` String.
      #
      def to_s
        "#{username}:#{password}"
      end

      #
      # Converts the credentials to a String.
      #
      # @return [(String, String)]
      #   Returns a tuple of the {#username} and {#password}.
      #
      def to_a
        [username, password]
      end

    end
  end
end
