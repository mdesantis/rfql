module RFQL
  class Query < String
    VALID_QUERY_METHODS = [:select, :from, :where, :order, :limit]
    def initialize(obj = '')
      if obj.is_a?(Hash)
        obj.each do |k, v|
          if VALID_QUERY_METHODS.include?(k)
            self.send(k, v)
          else
            raise ArgumentError, "hash keys expected to be included in #{VALID_QUERY_METHODS}; got #{k.inspect}"
          end
        end
        super(to_s)
      else
        @query = obj.to_s
      end
    end
    def to_s
      @query.present? ? @query.to_s : compose_query
    end
    def inspect
      to_s.inspect
    end
  end
end

# This is here in order to avoid conflicts between the RFQL::Query declarations
require 'rfql/query/methods'
RFQL::Query.send(:include, RFQL::Query::Methods)
