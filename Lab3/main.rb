require 'pry'
require_relative 'handler.rb'
require_relative 'queue.rb'
require_relative 'source.rb'
require_relative 'target_math.rb'

QUEUE_SIZE = 2

$states_probability = {
  '000' => 0,
  '001' => 0,
  '010' => 0,
  '011' => 0,
  '111' => 0
}

$p_failure = 0.0
$channel_load_1 = 0.0
$channel_load_2 = 0.0
$time_in_system = 0.0

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
  $ticks = 10000
  $step = 1.to_f / $ticks
end

def init
  $source = Source.new(1.to_f - $p)
  $queue = Queue.new(QUEUE_SIZE)
  $handler_1 = Handler.new(1.to_f - $pi1)
  $handler_2 = Handler.new(1.to_f - $pi2)

  $source.output << $queue
  $queue.input << $source

  $queue.output << $handler_1
  $queue.output << $handler_2
  $handler_1.input << $queue
  $handler_2.input << $queue
end

def proccess
  $step = 1.to_f / $ticks
  (1..$ticks).each do |_index|
    command_to_move
    $states_probability['000'] += $step if $queue.requests.zero? && !$handler_1.busy && !$handler_2.busy
    $states_probability['001'] += $step if $queue.requests.zero? && !$handler_1.busy && $handler_2.busy
    $states_probability['010'] += $step if $queue.requests.zero? && $handler_1.busy && !$handler_2.busy
    $states_probability['011'] += $step if $queue.requests.zero? && $handler_1.busy && $handler_2.busy
    $states_probability['111'] += $step if $queue.requests == 1 && $handler_1.busy && $handler_2.busy
  end
end

def command_to_move
  $channel_load_1 += $step if $handler_1.busy
  $channel_load_2 += $step if $handler_2.busy

  $source.generate_request

  $queue.add
  $handler_1.proccess

  $handler_2.proccess
  $p_failure += $step if $source.blocked

end

def output_data
  $states_probability.each { |key, value| puts format("Вероятность состояния #{key} = %.5f;", value) }

  puts format("Вероятность отказа: %.5f;", $p_failure)
  puts format("Вероятность занятости канала 1: %.5f;", $channel_load_1)
  puts format("Вероятность занятости канала 1: %.5f;", $channel_load_2)
  puts format("Среднее время пребывания заявки в системе: %.5f;", $time_in_system)
end

def main
  input_data
  init
  proccess
  output_data
end

main
