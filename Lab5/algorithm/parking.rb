module Base
  class Parking
    attr_accessor :input, :output, :cars

    def initialize(size)
      @size = size
      @input = []
      @output = []
      @cars = []
    end

    def full?
      @cars.count == @size
    end

    def empty?
      @cars.count.zero?
    end

    def process
      if (output[0].empty? || output[1].empty?) && @cars.count.positive?
        car = @cars.pop
        if output[0].empty?
          output[0].data = car
          car = nil
        end
        output[1].data = car if output[1].empty?
      end
    end

    def add(car)
      return raise ParkingOverflow.new, 'Parking overflow' if @cars.count >= 1

      @cars << car
      process if @cars.count == 1
    end

    def all_requests_tick
      @cars.each(&:tick)
    end
  end
end
