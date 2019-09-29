module Base
  class Dispenser
    attr_accessor :input, :output, :data
    attr_reader :number

    def initialize(number)
      @number = number
      @probability = 1 #probability
      @input = []
    end

    def empty?
      @data.nil?
    end

    def employable?
      !@probability.zero?
    end

    def proccess
      if rand < @probability && !empty?
        tmp_request = @data
        @data = nil
        output.add(tmp_request)
      end
    end

    def all_requests_tick
      @data.tick if @data
    end
  end
end
