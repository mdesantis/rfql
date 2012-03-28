module RFQL
  module Response
    class JSON
      class Parsed
        class Records < Array
          attr_reader :request, :raw
          def initialize(request, raw, array)
            @request, @raw = request, raw
            super(array)
          end
        end
      end
    end
  end
end
