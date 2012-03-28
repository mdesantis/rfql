module RFQL
  module Response
    class JSON
      class Raw < String
        attr_reader :request
        def initialize(request, open_uri_options = {})
          @request = request
          super RFQL::Response.read(request, open_uri_options)
        end
      end
    end
  end
end
