require 'terminal-table'
require_relative 'math_sequence'
require_relative 'parking_overflow'
require 'pry'
require "awesome_print"
require 'distribution'

Dir["algorithm/*.rb"].each { |file| require_relative file }

$result = {}

TICKS = 100000

def input_data
  # puts('Введите количество обслуживающих каналов')
  # $n = gets.chomp.to_i
  # puts('Введите минимальную длину очереди')
  # $m_min = gets.chomp.to_i
  # puts('Введите максимальную длину очереди')
  # $m_max = gets.chomp.to_i
  # puts('Введите λ параметр')
  # $intense = gets.chomp.to_f
  # puts('Введите время обслуживания')
  # $service_time = gets.chomp.to_f
  # puts('Введите цену обслуживания')
  # $price_process = gets.chomp.to_f
  # puts('Введите цену места в очереди')
  # $price_queue = gets.chomp.to_f

  # $m = ($m_min..$m_max)

  $n = 3
  $m = (0..20)
  $intense = 1.0
  $service_time = 3
  $price_process = 5
  $price_queue = 1.to_f / 3
  $p = $intense / (1.to_f / $service_time)
end

def create_objects(m)
  $source = Base::Source.new($intense)
  $parking = Base::Parking.new(m)
  n = -1
  $dispensers = $n.times.map { n += 1; Base::Dispenser.new(n, $service_time) }
  $declined_container = Base::Container.new
  $finished_container = Base::Container.new
end

def set_connections
  $source.output << $parking
  $source.output << $declined_container

  $parking.input << $source

  $dispensers.each do |dispenser|
    $parking.output << dispenser
    dispenser.input << $parking
    dispenser.output = $finished_container
  end
end

def init(m)
  create_objects(m)
  set_connections
end

def record_data(m, p_failure, profit)
  $result[m] = {
    p_failure: p_failure,
    profit: profit
  }
end

def proccess
  $ticks = 0
  $source.set_time
  $dispensers.each { |dispenser| dispenser.set_time }
  while $ticks < TICKS do
    command_to_move
    $ticks += 1
  end
end

def command_to_move
  $dispensers.each { |dispenser| dispenser.proccess }
  $parking.process

  request = $source.generate_request
  if request
    begin
      $parking.add(request)
    rescue ParkingOverflow
      $declined_container.add(request)
    end
  end
end

def output_data
  max_profit_index = 0
  $result.each do |key, tmp_table|
    puts "Длина очереди #{key}"
    puts "Вероятность отказа #{tmp_table[:p_failure].round(5)}"
    puts "Прибыль #{tmp_table[:profit].round(5)}"
    puts '------------------------------------'
    max_profit_index = key if $result[max_profit_index][:profit] < $result[key][:profit]
  end
  puts "Максимальная прибыль #{$result[max_profit_index][:profit]} при длине очереди #{max_profit_index}"
end

def main
  input_data
  $m.each do |m|
    init(m)
    proccess
    record_data(m, MathSequence.p_failure(m), MathSequence.profit(m))
  end
  output_data
end

main
