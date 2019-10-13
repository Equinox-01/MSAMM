module Base
  class Source
    attr_accessor :output, :blocked, :time_to_action, :time_from_previous_event

    def initialize(time)
      @time = time
      @blocked = false
      @output = []
      @distribution = Distribution::Exponential.rng(@time.to_f**-1)
    end

    def set_time
      @time_from_previous_event = $ticks
      @time_to_action = @distribution.call
    end

    def generate_request
      @time_to_action -= 1
      if @time_to_action <= 0
        set_time
        return Base::Car.new
      end
    end
  end
end
