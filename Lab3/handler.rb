class Handler
  attr_accessor :input, :output, :request

  def initialize(probability)
    @probability = probability
    @input = []
  end
end
