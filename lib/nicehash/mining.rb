require 'nicehash/mining/algorithm'

module Nicehash
  module Mining
    module Endpoints
      def fetch_algorithms
        algos = get.call(path: '/main/api/v2/mining/algorithms')
        algos['miningAlgorithms'].map { |a| Algorithm.new(a) }
      end

      def fetch_algorithm(name:)
        name = Types::Algorithms[name]
        algos = get.call(path: '/main/api/v2/mining/algorithms')
        one = algos['miningAlgorithms'].find { |a| a['algorithm'] == name }
        Algorithm.new(one)
      end
    end
  end
end
