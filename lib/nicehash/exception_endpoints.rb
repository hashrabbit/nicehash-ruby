module Nicehash
  module ExceptionEndpoints
    def self.included(klass)
      klass.instance_eval do
        def exception_endpoint! endpoint
          class_eval(<<-EVAL
            def #{endpoint}!(kwargs = {})
              unwrap!(#{endpoint}(**kwargs))
            end
          EVAL
          )
        end
      end
    end

    def unwrap!(result)
      result.value_or { |err|
        raise err if err.is_a?(Exception)
        raise Error.new(err)
      }
    end
  end
end
