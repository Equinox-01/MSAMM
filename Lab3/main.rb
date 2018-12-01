require "awesome_print"
require 'pry'
require_relative "handler.rb"
require_relative "queue.rb"
require_relative "source.rb"
require_relative "request.rb"

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
  # puts('Введите ρ параметр')
  # $p = gets.chomp.to_f
  # puts('Введите π1 параметр')
  # $pi1 = gets.chomp.to_f
  # puts('Введите π2 параметр')
  # $pi2 = gets.chomp.to_f
  # puts('Введите количество тактов')
  # $ticks = gets.chomp.to_i
  $p = 0.75
  $pi1 = 0.8
  $pi2 = 0.5
  $ticks = 10
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
  (1..$ticks).each do
    # binding.pry
    $source.generate_request
  end
end

def output_data
  $states_probability.each { |key, value| puts "Вероятность состояния #{key} = #{value};" }
end

def main
  input_data
  init
  proccess
  output_data
end

main