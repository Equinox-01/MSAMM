class Handler
  attr_accessor :input, :output, :data
  attr_reader :number

  def initialize(probability, number)
    @number = number
    @probability = probability
    @input = []
  end

  def empty?
    @data.nil?
  end

  def employable?
    !@probability.zero?
  end

  def proccess
    if rand < @probability && !empty?
      $channel_load_1 += 1 if @number == 1
      $channel_load_2 += 1 if @number == 2

      tmp_request = @data
      @data = nil
      output.add(tmp_request)
    end
  end

  def all_requests_tick
    @data.tick if @data
  end
end
