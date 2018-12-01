class Source
  attr_accessor :input, :output, :blocked

  def initialize(probability)
    @probability = probability
    @output = []
  end

  def blocked?
    @output[0].full?
  end

  def generate_request
    unless blocked?
      @output[0].add(Request.new) if rand <= @probability
    end
    @output[0].send_to_handlers
  end
end
