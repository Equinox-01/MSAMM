class Handler
  attr_accessor :input, :probability, :request

  def initialize(probability)
    @probability = probability
    @input = []
    @request = nil
  end

  def busy?
    @request != nil
  end

  def proccess
    @request = nil if rand <= probability
  end
end
