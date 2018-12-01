class Handler
  attr_accessor :input, :busy

  def initialize(probability)
    @probability = probability
    @input = []
    @busy = false
  end

  def proccess
    if @busy
      if rand <= @probability
        @busy = false
        if @input[0].requests >= 1
          @busy = true
          @input[0].requests -= 1
          if @input[0].input[0].blocked
            @input[0].input[0].blocked = false
            @input[0].requests += 1
          end
        end
      end
    else
      if @input[0].requests >= 1
        @busy = true
        @input[0].requests -= 1
        if @input[0].input[0].blocked
          @input[0].input[0].blocked = false
          @input[0].request += 1
        end
      end
    end
  end
end
