module RFQL
  module Response
    class JSON
      class Raw < String
        attr_reader :request
        def initialize(request, options = {})
          @request = request
          options[:format] = :json
          super RFQL::Response.read(request, options)
        end
      end
    end
  end
end
