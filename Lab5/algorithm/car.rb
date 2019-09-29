module Base
  class Car
    attr_reader :time_in_system, :overpast_elements, :finished

    def initialize
      @time_in_system = 0
      @finished = false
    end

    def tick
      @time_in_system += 1 unless @finished
    end

    def finish
      @finished = true
    end
  end
end
