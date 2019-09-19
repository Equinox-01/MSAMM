class Source
  attr_accessor :output, :blocked

  def initialize(probability)
    @probability = probability
    @blocked = false
    @output = []
  end

  def generate_request
    return nil unless rand <= @probability

    Request.new
  end
end
