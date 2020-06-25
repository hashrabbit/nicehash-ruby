require 'nicehash/mining/algorithm'

module Nicehash
  module Mining
    module Endpoints
      include ExceptionEndpoints
      exception_endpoint! :fetch_algorithms
      exception_endpoint! :fetch_algorithm

      def fetch_algorithms
        algos = get.call(path: '/main/api/v2/mining/algorithms')
        algos.fmap { |algos| algos['miningAlgorithms'].map { |algo| Algorithm.new(algo) } }
      end

      def fetch_algorithm(name:)
        name = Types::Algorithms[name]
        algos = get.call(path: '/main/api/v2/mining/algorithms')
        algos.fmap do |algos|
          one = algos['miningAlgorithms'].find { |a| a['algorithm'] == name }
          Algorithm.new(one)
        end
      end
    end
  end
end
