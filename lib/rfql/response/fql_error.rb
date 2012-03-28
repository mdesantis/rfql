module RFQL
  module Response
    class FQLError < StandardError
      attr_reader :request, :io, :data
      def initialize(message, io, request)
        super(message)
        @io, @request = io, request
        begin
          @data = ::JSON.parse @io.readlines.join("\n")
        rescue Exception
        end
      end
    end
  end
end
