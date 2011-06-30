require 'rfql/response/json'
require 'rfql/response/fql_error'

module RFQL
  module Response
    class << self
      def new(request, options = {})
        options[:format] ||= :json_parsed
        raise ArgumentError, 'illegal format' unless [:xml, :json_raw, :json_parsed].include?(options[:format])
        
        case options[:format]
          when :json_raw, :json_parsed
            options[:format] = options[:format] == :json_raw ? :raw : :parsed
            RFQL::Response::JSON.new(request, options)
          when :xml
            raise NotImplementedError
        end
      end
      def read(request, options = {})
        request_url = request.respond_to?(:to_url) ? request.to_url : request.to_s
        raise ArgumentError, 'illegal format' unless [:xml, :json].include?(options[:format])
        request_url << "&format=#{options[:format]}"
        URI.parse(request_url).read(options[:open_uri_options] || {})
      end
    end
  end
end
