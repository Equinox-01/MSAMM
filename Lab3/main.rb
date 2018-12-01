require 'pry'
require_relative "handler.rb"
require_relative "queue.rb"
require_relative "source.rb"
require_relative "request.rb"
require_relative "target_math.rb"

QUEUE_SIZE = 2

$states_probability = {
  '0000' => 0,
  '0001' => 0,
  '0010' => 0,
  '0011' => 0,
  '0111' => 0,
  '0211' => 0,
  '1211' => 0
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
  # $p = 0.75
  # $pi1 = 0.8
  # $pi2 = 0.5
  # $ticks = 100000
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
  (1..$ticks).each do |index|
    $states_probability['0000'] += 1.to_f / $ticks if (!$source.blocked && $queue.requests.zero? && !$handler_1.busy && !$handler_2.busy)
    $states_probability['0001'] += 1.to_f / $ticks if (!$source.blocked && $queue.requests.zero? && $handler_1.busy && !$handler_2.busy)
    $states_probability['0010'] += 1.to_f / $ticks if (!$source.blocked && $queue.requests.zero? && !$handler_1.busy && $handler_2.busy)
    $states_probability['0011'] += 1.to_f / $ticks if (!$source.blocked && $queue.requests.zero? && $handler_1.busy && $handler_2.busy)
    $states_probability['0111'] += 1.to_f / $ticks if (!$source.blocked && $queue.requests == 1 && $handler_1.busy && $handler_2.busy)
    $states_probability['0211'] += 1.to_f / $ticks if (!$source.blocked && $queue.requests == 2 && $handler_1.busy && $handler_2.busy)
    $states_probability['1211'] += 1.to_f / $ticks if ($source.blocked && $queue.requests == 2 && $handler_1.busy && $handler_2.busy)
    command_to_move
  end
end

def command_to_move
  $source.generate_request
  $queue.add
  $handler_1.proccess
  $handler_2.proccess
end

def output_data
  $states_probability.each { |key, value| puts "Вероятность состояния #{key} = %.5f;" % value }

  math = TargetMath.new
  puts("Среднее время пребывания заявки в системе %.5f" %math.average_time_spent_in_system($p, $states_probability['1211'], $states_probability))
  puts("Среднее число заявок находящихся в системе %.5f" % math.average_number_of_request_in_system($states_probability))
  puts("Абсолютная пропускная способность %.5f" % math.absolute_bandwidth($p, $states_probability['1211']))
end

def main
  input_data
  init
  proccess
  output_data
end

main
