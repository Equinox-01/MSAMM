class Queue
  attr_accessor :input, :output, :requests

  def initialize(size)
    @size = size
    @input = []
    @output = []
    @requests = []
  end

  def full?
    requests.size >= @size
  end
end
