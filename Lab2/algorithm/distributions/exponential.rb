# frozen_string_literal: true

require_relative '../lehmer.rb'

module Algorithm
  module Distribution
    class Exponential
      AMOUNT = 1_000_000

      def initialize(args)
        @rate = args['rate'].to_f
      end

      def sequence
        sequence = Algorithm::Lehmer.new(32_771, 1_046_527, 65_537).sequence
        sequence.map do |seq|
          - (1 / @rate) * Math.log(seq)
        end
      end
    end
  end
end
