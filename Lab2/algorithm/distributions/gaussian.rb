# frozen_string_literal: true

require_relative '../lehmer.rb'

module Algorithm
  module Distribution
    class Gaussian
      AMOUNT = 1_000_000
      N = 6

      def initialize(args)
        @mean = args['mean'].to_f
        @scale = args['scale'].to_f
      end

      def sequence
        sequence = (Algorithm::Lehmer.new(32_771, 1_046_527, 65_537).sequence * 6)
        index = 0
        result = []
        while index < sequence.count
          sub_sequence = sequence[index...(index + N)]
          result << @mean + @scale * Math.sqrt(12 / N) * ((sub_sequence.inject(0) { |sum, x| sum + x }) - N / 2)
          index += N
        end
        result
      end
    end
  end
end
