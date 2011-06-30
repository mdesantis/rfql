module RFQL
  module Response
    class JSON
      class Parsed
        class Records < Array
          attr_reader :request
          def initialize(request, array)
            @request = request
            super(array)
          end
        end
      end
    end
  end
end
