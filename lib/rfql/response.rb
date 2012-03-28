require 'open-uri'
require 'rfql/response/json'
require 'rfql/response/fql_error'

module RFQL
  module Response
    def self.read(request, open_uri_options = {})
      request_url = request.respond_to?(:to_url) ? request.to_url : request.to_s
      begin
        URI.parse(request_url).read(open_uri_options)
      rescue OpenURI::HTTPError => e
        raise RFQL::Response::FQLError.new(e.message, e.io, request)
        #raise RFQL::Response::HTTPError.new(e.message, e.io, request)
      end
    end
    def initialize(request, options = {})
      options[:format] ||= :json_parsed

      raise ArgumentError, 'illegal format' unless [:json_raw, :json_parsed].include?(options[:format])
      
      options[:format] = 
        case options[:format]
        when :json_raw    then :raw
        when :json_parsed then :parsed
        end
      
      RFQL::Response::JSON.new(request, options)
    end
  end
end
