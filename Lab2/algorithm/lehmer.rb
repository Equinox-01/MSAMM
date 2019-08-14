# frozen_string_literal: true

module Algorithm
  class Lehmer
    AMOUNT = 1_000_000

    def initialize(a_param, m_param, r0_param)
      @a = a_param
      @m = m_param
      @r0 = r0_param
    end

    def sequence
      sequence = Array.new(AMOUNT)
      rn = (@a * @r0) % @m
      sequence[0] = rn.to_f / @m
      AMOUNT.times.each do |i|
        rn = @a * rn % @m
        sequence[i] = rn.to_f / @m
      end
      sequence
    end
  end
end
