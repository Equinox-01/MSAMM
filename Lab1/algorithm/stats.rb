module Algorithm
  class Stats
    attr_reader :expected, :dispersion, :standard_deviation,
                :indirect_evaluation, :period_length, :aperiodicity

    MEASURE_ROUNDING = 6

    def initialize(sequence)
      @sequence = sequence
      execute
    end

    private

    def execute
      sum = @sequence.sum
      @expected = sum.to_f / @sequence.count
      sum_dispersion = 0
      @sequence.count.times.each do |index|
        sum_dispersion += (@sequence[index] - @expected) * (@sequence[index] - @expected)
      end
      @dispersion = sum_dispersion.to_f / @sequence.count
      @standard_deviation = Math.sqrt(@dispersion)
      @indirect_evaluation = 2 * amount_of_pairs_for_indirectevaluation.to_f / @sequence.count
      @period_length = length_of_period
      @aperiodicity = length_of_aperiodism
    end

    def amount_of_pairs_for_indirectevaluation
      amount = index = 0
      while index < @sequence.count
        amount += 1 if (@sequence[index]**2 + @sequence[index + 1]**2).to_f < 1
        index += 2
      end
      amount
    end

    def length_of_period
      v = @sequence[-1]
      is_start = false
      tmp = 0
      @sequence.count.times.each do |index|
        if @sequence[index] == v
          if !is_start
            tmp = index
            is_start = true
          else
            return index - tmp
          end
        end
      end
      0
    end

    def length_of_aperiodism
      @sequence.each_with_index do |tmp_seq, index|
        return index + @period_length if (index + @period_length < @sequence.count) &&
                                         (tmp_seq == @sequence[index + @period_length])
      end
      0
    end
  end
end
