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

def input_data
  puts('Введите ρ параметр')
  $p = gets.chomp.to_f
  puts('Введите π1 параметр')
  $pi1 = gets.chomp.to_f
  puts('Введите π2 параметр')
  $pi2 = gets.chomp.to_f
  puts('Введите количество тактов')
  $ticks = gets.chomp.to_i
  # $p = 0.3
  # $pi1 = 0.75
  # $pi2 = 0.75
  # $ticks = 1000000
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
  step = 1.to_f / $ticks
  (1..$ticks).each do |_index|
    command_to_move
    $states_probability['000'] += step if $queue.requests.zero? && !$handler_1.busy && !$handler_2.busy
    $states_probability['001'] += step if $queue.requests.zero? && !$handler_1.busy && $handler_2.busy
    $states_probability['010'] += step if $queue.requests.zero? && $handler_1.busy && !$handler_2.busy
    $states_probability['011'] += step if $queue.requests.zero? && $handler_1.busy && $handler_2.busy
    $states_probability['111'] += step if $queue.requests == 1 && $handler_1.busy && $handler_2.busy
  end
end

def command_to_move
  $source.generate_request
  $queue.add
  $handler_1.proccess
  $handler_2.proccess
end

def output_data
  $states_probability.each { |key, value| puts format("Вероятность состояния #{key} = %.5f;", value) }
  # math = TargetMath.new
  # puts(format('Среднее время пребывания заявки в системе %.5f', math.average_time_spent_in_system($p, $states_probability['1211'], $states_probability)))
  # puts(format('Среднее число заявок находящихся в системе %.5f', math.average_number_of_request_in_system($states_probability)))
  # puts(format('Абсолютная пропускная способность %.5f', math.absolute_bandwidth($p, $states_probability['1211'])))
end

def main
  input_data
  init
  proccess
  output_data
end

main
