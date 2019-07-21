module Algorithm
  class Chart
    INTERVALS = 20
    def self.build_chart(sequence)
      intervals = Array.new(INTERVALS)
      length = sequence.count
      min = sequence.min
      range = sequence.max - sequence.min
      delta = range.to_f / INTERVALS
      intervals[0] = delta
      (1..INTERVALS).each { |index| intervals[index] = delta + intervals[index - 1] }
      numOfHits = Array.new(INTERVALS).fill(0)
      (0...length).each do |index|
        INTERVALS.times.each do |sec_index|
          tmp = min + sec_index * delta
          if (sequence[index] >= tmp) && (sequence[index] <= tmp + delta)
            numOfHits[sec_index] += 1
            break
          end
        end
      end

      frequencies = Array.new(INTERVALS)
      INTERVALS.times.each { |index| frequencies[index] = numOfHits[index].to_f / 1000000.to_f }
      result = {}
      INTERVALS.times.each { |index| result.merge!(((min + delta * (index + 1)).round(3)) => frequencies[index]) }
      result
    end
  end
end