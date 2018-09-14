module Algorithm
  class Chart
    INTERVALS = 20
    def self.build_chart(sequence)
      intervals = Array.new(INTERVALS)
      range = sequence.max - sequence.min
      delta = range.to_f / INTERVALS
      intervals[0] = delta
      (1..INTERVALS).each { |index| intervals[index] = delta = intervals[index - 1] }

    end
  end
end