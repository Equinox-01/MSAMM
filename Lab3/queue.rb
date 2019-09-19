# frozen_string_literal: true

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

  def empty?
    @requests.count.zero?
  end

  def process
    if (output[0].empty? || output[1].empty?) && @requests.count.positive?
      request = @requests.pop
      if output[0].empty?
        output[0].data = request
        request = nil
      end
      output[1].data = request if output[1].empty?
    end
  end

  def add(request)
    return raise QueueOverflow.new, 'Queue overflow' if @requests.count >= 1

    @requests << request
    process if @requests.count == 1
  end

  def all_requests_tick
    @requests.each(&:tick)
  end
end
