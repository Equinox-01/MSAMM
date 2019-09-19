require 'pry'

require_relative 'handler.rb'
require_relative 'queue.rb'
require_relative 'source.rb'
require_relative 'request.rb'
require_relative 'container.rb'
require_relative 'target_math.rb'
require_relative 'queue_overflow.rb'

QUEUE_SIZE = 1

$states_probability = {
  '000' => 0,
  '001' => 0,
  '010' => 0,
  '011' => 0,
  '111' => 0
}

$channel_load_1 = 0
$channel_load_2 = 0

def input_data
  # puts('Введите ρ параметр')
  # $p = gets.chomp.to_f
  # puts('Введите π1 параметр')
  # $pi1 = gets.chomp.to_f
  # puts('Введите π2 параметр')
  # $pi2 = gets.chomp.to_f
  # puts('Введите количество тактов')
  # $ticks = gets.chomp.to_i
  $p = 0.3
  $pi1 = 0.75
  $pi2 = 0.75
  $ticks = 10_000
  # $p = 0.5
  # $pi1 = 0.0
  # $pi2 = 0.0
  # $ticks = 10000
  $step = 1.to_f / $ticks
end

def create_objects
  $source = Source.new(1.to_f - $p)
  $queue = Queue.new(QUEUE_SIZE)
  $handler_1 = Handler.new(1.to_f - $pi1)
  $handler_2 = Handler.new(1.to_f - $pi2)
  $declined_container = Container.new
  $finished_container = Container.new

  $objects = [$queue, $handler_1, $handler_2]
end

def set_connections
  $source.output << $queue
  $source.output << $declined_container

  $queue.input << $source
  $queue.output << $handler_1
  $queue.output << $handler_2

  $handler_1.input << $queue
  $handler_2.input << $queue

  $handler_1.output = $finished_container
  $handler_2.output = $finished_container
end

def init
  create_objects
  set_connections
end

def process_probabilities
  $states_probability['000'] += $step if $queue.empty? && $handler_1.empty? && $handler_2.empty?
  $states_probability['001'] += $step if $queue.empty? && $handler_1.empty? && !$handler_2.empty?
  $states_probability['010'] += $step if $queue.empty? && !$handler_1.empty? && $handler_2.empty?
  $states_probability['011'] += $step if $queue.empty? && !$handler_1.empty? && !$handler_2.empty?
  $states_probability['111'] += $step if !$queue.empty? && !$handler_1.empty? && !$handler_2.empty?

  $channel_load_1 += 1 unless $handler_1.empty?
  $channel_load_2 += 1 unless $handler_2.empty?
end

def proccess
  (1..$ticks).each do |_index|
    process_probabilities
    command_to_move
  end
end

def command_to_move

  $handler_1.proccess
  $handler_2.proccess
  $queue.process

  request = $source.generate_request
  if request
    begin
      $queue.add(request)
    rescue QueueOverflow
      $declined_container.add(request)
    end
  end
  $objects.each(&:all_requests_tick)
end

def output_data
  counter = 0
  $finished_container.data.each { |object| counter += object.time_in_system } unless $finished_container.data.empty?
  time_in_system = counter.to_f / ($finished_container.size + $declined_container.size)

  $states_probability.each { |key, value| puts format("Вероятность состояния #{key} = %.5f;", value) }
  puts format("Вероятность отказа: %.5f;", $declined_container.size.to_f / $ticks)
  puts format("Вероятность занятости канала 1: %.5f;", $channel_load_1.to_f / $ticks)
  puts format("Вероятность занятости канала 2: %.5f;", $channel_load_2.to_f / $ticks)
  puts format("Среднее время пребывания заявки в системе: %.5f;", time_in_system)
end

def main
  input_data
  init
  proccess
  output_data
end

main
