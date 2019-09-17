class Queue
  attr_accessor :input, :output, :requests

  def initialize(size)
    @size = size
    @input = []
    @output = []
    @requests = 0
  end

  def full?
    @requests.count == @size
  end

  def add
    if @requests < 1
      if @input[0].blocked
        @requests += 1
        @input[0].blocked = false
      end
    end
  end
end
