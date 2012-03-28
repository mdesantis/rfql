require 'rfql/response/json/raw'
require 'rfql/response/json/parsed'
require 'rfql/response/json/parsed/records'
require 'rfql/response/json/parsed/null'
require 'rfql/response/json/parsed/error'

module RFQL
  module Response
    class JSON
      # Overwriting self.new in order to return another object depending to the format option
      def self.new(request, options = {})
        defaults = { :format => :parsed, :open_uri_options => {}, :json_parse_options => {} }
        options  = defaults.merge(options)

        format = options.delete(:format)
        raise ArgumentError, 'illegal format' unless [:raw, :parsed].include? format
        
        case format
        when :raw    then RFQL::Response::JSON::Raw.new(request, options[:open_uri_options])
        when :parsed then RFQL::Response::JSON::Parsed.new(request, options)
        end
      end
    end
  end
end
