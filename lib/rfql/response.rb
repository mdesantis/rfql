require 'open-uri'

require 'rfql/response/json'
require 'rfql/response/fql_error'

module RFQL
  module Response
    class << self
      def new(request, options = {})
        options[:format] ||= :json_parsed
        raise ArgumentError, 'illegal format' unless [:json_raw, :json_parsed].include?(options[:format])
        
        options[:format] = options[:format].to_s[/^json_(.*)/, 1].to_sym
        
        RFQL::Response::JSON.new(request, options)
      end
      
      def read(request, options = {})
        request_url = request.respond_to?(:to_url) ? request.to_url : request.to_s
        URI.parse(request_url).read(options[:open_uri_options] || {})
      end
    end
  end
end
