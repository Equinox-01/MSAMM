module Base
  class Container
    attr_reader :data

    def initialize
      @data = []
    end

    def add(car)
      car.finish
      @data << car
    end

    def size
      @data.count
    end

    def all_requests_tick
      @data.each { |car| car.tick }
    end
  end
end
