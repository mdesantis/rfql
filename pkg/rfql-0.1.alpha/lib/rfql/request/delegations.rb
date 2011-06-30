module RFQL
  class Request
    module QueryMethodsDelegations
      def select(*fields);    query.select(*fields); self; end
      def from(from = nil);   query.from(from);      self; end
      def where(where = nil); query.where(where);    self; end
      def order(order = nil); query.order(order);    self; end
      def limit(limit = nil); query.limit(limit);    self; end
    end
  end
end
