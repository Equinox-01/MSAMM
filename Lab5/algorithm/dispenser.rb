module Base
  class Dispenser
    attr_accessor :input, :output, :data, :time_to_action, :time_from_previous_event
    attr_reader :number, :time_of_service

    def initialize(number, time_of_service)
      @number = number
      @time_of_service = time_of_service
      @input = []
      @distribution = Distribution::Exponential.rng(@time.to_f**-1)
    end

    def empty?
      @data.nil?
    end

    def employable?
      !@time_of_service.zero?
    end

    def set_time
      @time_from_previous_event = $ticks
      @time_to_action = @distribution.call
    end

    def proccess
      @time_to_action -= 1
      if @time_to_action <= 0 && !empty?
        tmp_request = @data
        @data = nil
        output.add(tmp_request)
        set_time
      end
    end
  end
end
