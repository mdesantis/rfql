module RFQL
  module Response
    class JSON
      class Parsed
        class Error < Hash
          attr_reader :request, :raw
          def initialize(request, raw, hash)
            @request, @raw = request, raw
            merge!(hash)
            # FIXME SyntaxError, dunno why
            # hash.keys.each do |key|
            #   self.class.class_eval<<-"RB"
            #     def #{key}
            #       send :fetch, #{key}
            #     end
            #   RB
            # end
          end
        end
      end
    end
  end
end
