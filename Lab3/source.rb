class Source
  attr_accessor :input, :output, :blocked

  def initialize(probability)
    @probability = probability
    @blocked = false
    @output = []
  end

  def generate_request
    unless blocked
      @blocked = rand <= @probability
    end
  end
end
