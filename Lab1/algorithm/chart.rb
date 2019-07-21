module Algorithm
  class Chart
    INTERVALS = 20

    def initialize(sequence)
      @intervals = Array.new(INTERVALS)
      @length = sequence.count
      @min = sequence.min
      range = sequence.max - sequence.min
      @delta = range.to_f / INTERVALS
      @sequence = sequence
    end

    def build_chart
      @intervals[0] = @delta
      (1..INTERVALS).each { |index| @intervals[index] = @delta + @intervals[index - 1] }
      num_of_hits = Array.new(INTERVALS).fill(0)
      (0...@length).each do |index|
        INTERVALS.times.each do |sec_index|
          tmp = @min + sec_index * @delta
          if (@sequence[index] >= tmp) && (@sequence[index] <= tmp + @delta)
            num_of_hits[sec_index] += 1
            break
          end
        end
      end

      frequencies = Array.new(INTERVALS)
      INTERVALS.times.each { |index| frequencies[index] = num_of_hits[index].to_f / 1_000_000 }
      result = {}
      INTERVALS.times.each { |index| result[(@min + @delta * (index + 1)).round(3)] = frequencies[index] }
      result
    end
  end
end
