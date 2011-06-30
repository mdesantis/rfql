module RFQL
  module Response
    class FQLError < StandardError
      attr_reader :error
      def initialize(error)
        @error = error
      end
    end
  end
end
