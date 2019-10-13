module Base
  class Car
    attr_reader :time_in_system, :overpast_elements, :finished

    def initialize
      @time_in_system = 0
      @finished = false
    end

    def add_time(time)
      @time_in_system += time unless @finished
    end

    def finish
      @finished = true
    end
  end
end
