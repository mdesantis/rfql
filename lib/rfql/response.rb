require 'open-uri'

require 'rfql/response/json'
require 'rfql/response/fql_error'

module RFQL
  module Response

    RESPONSE_FORMATS = { json_parsed: :parsed, json_raw: :raw }
    ALLOWED_FORMATS  = RESPONSE_FORMATS.keys
    DEFAULT_FORMAT   = ALLOWED_FORMATS.first

    def self.read(request, open_uri_options = {})
      request_url = request.respond_to?(:to_url) ? request.to_url : request.to_s

      begin
        URI.parse(request_url).read(open_uri_options)
      rescue OpenURI::HTTPError => e
        raise FQLError.new(e.message, e.io, request)
        #raise RFQL::Response::HTTPError.new(e.message, e.io, request)
      end
    end

    def initialize(request, options = {})
      options[:format] ||= DEFAULT_FORMAT

      unless ALLOWED_FORMATS.include? options[:format]
        raise ArgumentError, "illegal format (should be one between #{ALLOWED_FORMATS.join(', ')}" 
      end
      
      options[:format] = RESPONSE_FORMATS[options[:format]]
      
      JSON.new(request, options)
    end
  end
end
