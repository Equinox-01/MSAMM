require 'terminal-table'
require_relative 'math_sequence'
require_relative 'parking_overflow'
require 'pry'

Dir["algorithm/*.rb"].each { |file| require_relative file }

$result = {}

TICKS = 10000

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
  # $m = ($m_min..$m_max)

  $n = 2
  $m = (3..7)
  $intense = 1.0
  $service_time = 2
  $p = $intense / (1.to_f / $service_time)
end

def create_objects(m)
  $source = Base::Source.new($intense)
  $parking = Base::Parking.new(m)
  $dispensers = $n.times.map { Base::Dispenser.new($service_time) }
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

def record_data(m, p_failure, parking_loading)
  $result[m] = {
    p_failure: p_failure,
    parking_loading: parking_loading
  }
end

def proccess
  (1..TICKS).each { |_index| command_to_move }
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
  $result.each do |key, tmp_table|
    puts "Длина очереди #{key}"
    rows = []
    rows << ['Вероятность отказа', tmp_table[:p_failure].round(5)]
    rows << ['Загрузка парковки', tmp_table[:parking_loading].round(5)]
    puts Terminal::Table.new(rows: rows)
  end
end

def main
  input_data
  $m.each do |m|
    init(m)
    proccess
    record_data(m, MathSequence.p_failure(m), MathSequence.parking_loading(m))
  end
  output_data
end

main
