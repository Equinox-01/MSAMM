# frozen_string_literal: true

require_relative '../lehmer.rb'
require_relative 'uniform.rb'

module Algorithm
  module Distribution
    class Simpson
      AMOUNT = 1_000_000

      def initialize(args)
        @a = args['a'].to_f
        @b = args['b'].to_f
      end

      def sequence
        uniform_sequence = Algorithm::Distribution::Uniform.new('a' => (@a / 2), 'b' => (@b / 2)).sequence * 2
        index = 0
        result = []
        while index < uniform_sequence.count
          result << uniform_sequence[index] + uniform_sequence[index + 1]
          index += 2
        end
        result
      end
    end
  end
end
