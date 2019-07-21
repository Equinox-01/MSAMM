module Algorithm
  class Stats
    MEASURE_ROUNDING = 6
    def initialize(sequence)
      @sequence = sequence
      sum = sequence.sum
      @expected = sum.to_f / @sequence.count
      sum = 0
      sequence.each_with_index {|tmp_seq, index| sum += (sequence[index] - @expected) * (sequence[index] - @expected) }
      @dispersion = sum.to_f / sequence.count
      @standardDeviation = Math.sqrt(@dispersion)
      @indirectEvaluation = 2 * amount_of_pairs_for_indirectevaluation.to_f / sequence.count
      @period_length = length_of_period
      @aperiodicity = length_of_aperiodism(@period_length)
    end
    # Take all values to methods & memoized

    def amount_of_pairs_for_indirectevaluation
      amount = 0
      i = 0
      while (i < @sequence.length)
        amount += 1 if ((@sequence[i].to_f * @sequence[i].to_f + @sequence[i + 1].to_f * @sequence[i + 1].to_f).to_f < 1)
        i = i + 2
      end
      amount
    end

    def length_of_period
      v = @sequence[@sequence.length - 1]
      isStart = false
      i1 = 0
      (0..@sequence.length).each do |index|
        if @sequence[index] == v
          if (!isStart)
            i1 = index
            isStart = true
          else
            return index - i1
          end
        end
      end
      return 0
    end

    def length_of_aperiodism(period)
      @sequence.each_with_index do |tmp_seq, index|
        if (index + @period_length < @sequence.count)
          if (tmp_seq == @sequence[index + @period_length])
            return index + @period_length
          end
        end
      end
      return 0
    end
  end
end