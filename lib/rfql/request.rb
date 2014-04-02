require 'rfql/core_ext/object/blank'
require 'rfql/query'
require 'rfql/request/delegations'
require 'rfql/response'

module RFQL
  class Request
    include QueryMethodsDelegations
    
    FQLURL = "https://graph.facebook.com/fql"
    
    attr_reader :response
    
    def initialize(str = nil)
      @query = Query.new(str)
    end
    
    def query(query = nil)
      return @query if query.nil?
      @query = Query.new(query)
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
    
    def response(json_format = :parsed, options = {})
      begin
        response!(json_format, options)
      rescue Response::FQLError
        nil
      end
    end
    
    # Examples:
    #   RFQL.request.select('aid, owner, name, object_id').from('album').where(:aid => "20531316728_324257").response
    #   RFQL.request.query('SELECT aid, owner, name, object_id FROM album WHERE aid="20531316728_324257"').response
    def response!(json_format = :parsed, options = {})
      raise ArgumentError, "illegal format" unless [:raw, :parsed].include?(json_format)
      
      unless options.is_a?(Hash) and (options.keys - [:open_uri_options, :json_parse_options, :force_execution]).blank?
        raise ArgumentError, "illegal options"
      end
      
      if not options.delete(:force_execution) and @cached_response
        case json_format
        when :raw    then return @cached_response.raw
        when :parsed then return @cached_response
        end
      end
      
      json_parse_opts    = options[:json_parse_options] || {}
      open_uri_read_opts = options[:open_uri_options]   || {}
      
      @cached_response = Response::JSON.new self, options.merge(:format => :parsed)
      
      raise Response::FQLError.new(@cached_response) if @cached_response.is_a?(RFQL::Response::JSON::Parsed::Error)
      
      case json_format
      when :raw    then @cached_response.raw
      when :parsed then @cached_response
      end
    end
  end
end
