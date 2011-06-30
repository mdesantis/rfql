module RFQL
  module Response
    class JSON
      class Parsed
        attr_reader :request, :response
        def self.new(request, options = {})
          json_raw_response = RFQL::Response::JSON::Raw.new(request, options)
          
          json_parsed_response = ::JSON.parse(json_raw_response, options[:json_parse_options] || {})
          
          if json_parsed_response.is_a?(Hash) and json_parsed_response.has_key?('error_code')
            RFQL::Response::JSON::Parsed::Error.new(request, json_parsed_response)
          elsif json_parsed_response.is_a?(Array)
            RFQL::Response::JSON::Parsed::Records.new(request, json_parsed_response)
          else
            super(request, json_parsed_response)
          end
        end
       private
        def initialize(request, json_parsed_response)
          @request, @response = request, json_parsed_response
        end
      end
    end
  end
end
