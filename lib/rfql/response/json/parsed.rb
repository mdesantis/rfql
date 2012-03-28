require 'json'
module RFQL
  module Response
    class JSON
      class Parsed
        attr_reader :request, :raw, :data
        # Overwriting of self.new in order to return a different type of object
        # in some cases
        def self.new(request, options = {})
          defaults = { :open_uri_options => {}, :json_parse_options => {} }
          options  = defaults.merge(options)

          json_raw_data    = RFQL::Response::JSON::Raw.new(request, options[:open_uri_options])
          json_parsed_data = ::JSON.parse(json_raw_data, options[:json_parse_options])
          
          if json_parsed_data.is_a?(Hash) and json_parsed_data['data'].is_a?(Array)
            RFQL::Response::JSON::Parsed::Records.new(request, json_raw_data, json_parsed_data['data'])
          else
            super(request, json_raw_data, json_parsed_data)
          end
        end
        private
        def initialize(request, json_raw_data, json_parsed_data)
          @request, @raw, @data = request, json_raw_data, json_parsed_data
        end
      end
    end
  end
end
