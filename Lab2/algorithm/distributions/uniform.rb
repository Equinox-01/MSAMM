# frozen_string_literal: true

require_relative '../lehmer.rb'

module Algorithm
  module Distribution
    class Uniform
      AMOUNT = 1_000_000

      def initialize(args)
        @a = args['a'].to_f
        @b = args['b'].to_f
      end

      def sequence
        sequence = Algorithm::Lehmer.new(32_771, 1_046_527, 65_537).sequence
        sequence.map do |seq|
          @a + (@b - @a) * seq
        end
      end
    end
  end
end
