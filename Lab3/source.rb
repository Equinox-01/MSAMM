class Source
  attr_accessor :input, :output, :blocked, :request

  def initialize(probability)
    @probability = probability
    @blocked = false
    @output = []
  end

  def blocked?
    return @output[0].full?
    raise NotImplementedError
  end

  def generate_request
    $states_probability['1211'] += 1.to_f / $ticks if blocked?
    unless blocked?
      output[0].requests.add(Request.new) if rand() <= @probability
    end
  end
end
