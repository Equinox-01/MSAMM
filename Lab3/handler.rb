class Handler
  attr_accessor :input, :output, :data

  def initialize(probability)
    @probability = probability
    @input = []
  end

  def empty?
    @data.nil?
  end

  def proccess
    if rand < @probability && !empty?
      tmp_request = @data
      @data = nil
      output.add(tmp_request)
    end
  end

  def all_requests_tick
    @data.tick if @data
  end
end
