class Container
  attr_reader :data

  def initialize
    @data = []
  end

  def add(request)
    request.finish
    @data << request
  end

  def size
    @data.count
  end

  def all_requests_tick
    @data.each { |request| request.tick }
  end
end
