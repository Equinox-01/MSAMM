module Algorithm
  class Lehmer
    AMOUNT = 1000000

    def initialize(a, m, r0)
      @a = a
      @m = m
      @r0 = r0
    end

    def sequence
      sequence = Array.new(AMOUNT)
      rn = (@a * @r0) % @m
      sequence[0] = rn.to_f / @m
      (1..AMOUNT).each do |i|
        rn = @a * rn % @m
        sequence[i] = rn.to_f / @m
      end
      tmp = sequence[0..10]
      sequence
    end
  end
end