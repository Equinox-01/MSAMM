class Handler
  attr_accessor :input, :busy

  def initialize(probability)
    @probability = probability
    @input = []
    @busy = false
  end

  def proccess
    unless @busy
      if $queue.requests >= 1
        @busy = true
        $queue.requests -= 1
        if $source.blocked
          $source.blocked = false
          $queue.request += 1
        end
      end
    else
      if rand <= @probability
        @busy = false
        if $queue.requests >= 1
          @busy = true
          $queue.requests -= 1
          if $source.blocked
            $source.blocked = false
            $queue.requests += 1
          end
        end
      end
    end
  end
end
