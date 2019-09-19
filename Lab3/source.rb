class Source
  attr_accessor :input, :output, :blocked

  def initialize(probability)
    @probability = probability
    @blocked = false
    @output = []
  end

  def generate_request
    $time_in_system += 1 if blocked
    @blocked = rand <= @probability unless blocked
  end
end
