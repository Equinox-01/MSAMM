class Queue
  attr_accessor :input, :output, :requests

  def initialize(size)
    @size = size
    @input = []
    @output = []
    @requests = []
  end

  def full?
    @requests.count == @size
  end

  def add(request)
    @requests << request
  end

  def send_to_handlers
    unless @output[0].busy?
      request = @requests.shift
      @output[0].request = request
    end
    unless @output[1].busy?
      request = @requests.shift
      @output[1].request = request
    end
    @output.each {|handler| handler.proccess}
  end
end
