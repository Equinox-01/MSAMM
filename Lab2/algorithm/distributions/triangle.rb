# frozen_string_literal: true

require_relative '../lehmer.rb'

module Algorithm
  module Distribution
    class Triangle
      AMOUNT = 1_000_000

      def initialize(args)
        @a = args['a'].to_f
        @b = args['b'].to_f
      end

      def sequence
        sequence = Algorithm::Lehmer.new(32_771, 1_046_527, 65_537).sequence
        index = 0
        result = []
        while index < sequence.count - 1
          result << @a + (@b - @a) * [sequence[index], sequence[index + 1]].max
          index += 1
        end
        result
      end
    end
  end
end
