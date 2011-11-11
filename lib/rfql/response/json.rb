require 'rfql/response/json/raw'
require 'rfql/response/json/parsed'
require 'rfql/response/json/parsed/records'
require 'rfql/response/json/parsed/null'
require 'rfql/response/json/parsed/error'

module RFQL
  module Response
    class JSON
      def self.new(request, options = {})
        options[:format] ||= :parsed
        raise ArgumentError, 'illegal format' unless [:raw, :parsed].include?(options[:format])
        
        case options[:format]
          when :raw    then RFQL::Response::JSON::Raw.new(request, options)
          when :parsed then RFQL::Response::JSON::Parsed.new(request, options)
        end
      end
    end
  end
end
