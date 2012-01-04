require 'rfql/core_ext/object/blank'
require 'rfql/query'
require 'rfql/request/delegations'
require 'rfql/response'

module RFQL
  class Request
    include RFQL::Request::QueryMethodsDelegations
    
    FQLURL = "https://graph.facebook.com/fql"
    
    attr_reader :response
    
    def initialize(str = nil)
      @query = RFQL::Query.new(str)
    end
    
    def query(query = nil)
      return @query if query.nil?
      @query = RFQL::Query.new(query)
      self
    end
      
    def to_sql
      @query.to_s
    end
    
    def access_token(access_token = nil)
      return @access_token if access_token.nil?
      @access_token = access_token
      self
    end
    
    def params
      {:q => to_sql, :access_token => access_token}
    end
    
    def to_url
      FQLURL + '?' + hash_to_params_string(params)
    end
    
    def hash_to_params_string(params)
      params.to_a.select do |param|
        param[0].present? and param[1].present?
      end.map do |param|
        "%s=%s" % [CGI.escape(param[0].to_s), CGI.escape(param[1].to_s)]
      end.join('&')
    end
    
    def fetch(json_format = :parsed, options = {})
      begin
        fetch!(json_format, options)
      rescue RFQL::Response::FQLError
        nil
      end
    end
    
    # Example: RFQL.request.query('SELECT aid, owner, name, object_id FROM album WHERE aid="20531316728_324257"').fetch
    def fetch!(json_format = :parsed, options = {})
      raise ArgumentError, "illegal format" unless [:raw, :parsed].include?(json_format)
      unless options.is_a?(Hash) and (options.keys - [:open_uri_options, :json_parse_options, :force_execution]).blank?
        raise ArgumentError, "illegal options"
      end
      
      if options.delete(:force_execution).blank? and @response and
         ( ( json_format == :parsed and ( @response.is_a?(RFQL::Response::JSON::Parsed) or
                                          @response.is_a?(RFQL::Response::JSON::Parsed::Records) or
                                          @response.is_a?(RFQL::Response::JSON::Parsed::Error) ) ) or
           ( json_format == :raw and @response.is_a?(RFQL::Response::JSON::Raw) ) )
        return @response
      end
      
      json_parse_opts = options[:json_parse_options] || {}
      open_uri_read_opts = options[:open_uri_options] || {}
      
      @response = RFQL::Response::JSON.new(self, options.merge(:format => json_format))
      
      raise RFQL::Response::FQLError.new(@response) if @response.is_a?(RFQL::Response::JSON::Parsed::Error)
      
      @response
    end
  end
end
