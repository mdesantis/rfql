require 'rfql/core_ext/object/blank'
require 'rfql/query'
require 'rfql/request/delegations'
require 'rfql/response'

module RFQL
  class Request
    include RFQL::Request::QueryMethodsDelegations
    
    attr_reader :response
    
    def initialize(str = nil)
      @query = RFQL::Query.new(str)
      @format_param = :json
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
    
    def format_param(format_param = nil)
      return @format_param if format_param.nil?
      raise ArgumentError, "illegal format" unless [:json, :xml].include?(format_param)
      @format_param = format_param
      self
    end
    
    def params(with_format_param = false)
      params = {:query => to_sql, :access_token => access_token}
      return params unless with_format_param
      params.merge(:format => @format_param)
    end
    
    def to_url(with_format_param = false)
      RFQL::FQLURL + '?' + hash_to_params_string(params(with_format_param))
    end
    
    def hash_to_params_string(params)
      params.to_a.select do |param|
        param[0].present? and param[1].present?
      end.map do |param|
        k, v = URI.escape(param[0].to_s), URI.escape(param[1].to_s)
        k.gsub!('&', '%26'); k.gsub!('=', '%3D'); v.gsub!('&', '%26'); v.gsub!('=', '%3D')
        "#{k}=#{v}"
      end.join('&')
    end
    
    def to_json(json_format = :parsed, options = {})
      begin
        to_json!(json_format, options)
      rescue RFQL::Response::FQLError
        nil
      end
    end
    
    def to_json!(json_format = :parsed, options = {})
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
