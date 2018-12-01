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
    if @requests < 2
      if $source.blocked
        @requests += 1
        $source.blocked = false
      end
    end
  end
end
