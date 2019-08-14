# frozen_string_literal: true

require_relative '../lehmer.rb'

module Algorithm
  module Distribution
    class Gamma
      AMOUNT = 1_000_000

      def initialize(args)
        @shape = args['shape'].to_f
        @scale = args['scale'].to_f
      end

      def sequence
        sequence = Algorithm::Lehmer.new(32_771, 1_046_527, 65_537).sequence
        index = 0
        result = []
        while index < sequence.count
          sub_sequence = sequence[index...(index + @shape)]
          result << - (1 / @scale.to_f) * Math.log(sub_sequence.inject(:*))
          index += 1
        end
        result
      end
    end
  end
end
