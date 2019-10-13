module Base
  class Parking
    attr_accessor :input, :output, :cars

    def initialize(size)
      @size = size
      @input = []
      @output = []
      @cars = []
    end

    def size
      @cars.count
    end

    def full?
      @cars.count == @size
    end

    def empty?
      @cars.count.zero?
    end

    def process
      empty_car_index = -1
      output.each_with_index { |output_tmp, index| empty_car_index = index if output_tmp.empty? }
      return if empty_car_index == -1

      if empty_car_index != -1 && @cars.count.positive?
        car = @cars.pop
        output[empty_car_index].data = car if output[empty_car_index].empty?
      end
    end

    def add(car)
      return raise ParkingOverflow.new, 'Parking overflow' if @cars.count >= 1

      @cars << car
      process if @cars.count == 1
    end
  end
end
