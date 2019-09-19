# frozen_string_literal: true

require_relative '../main.rb'

describe 'Main sequence' do
  let(:standard_input) { [0.3, 0.75, 0.75] }
  let(:standard_output) { [0.38, 0.96, 0.92, 1.44] }
  let(:clear_variables) { $p_failure = $channel_load_1 = $channel_load_2 = $time_in_system = 0 } 

  let(:process) do
    $p = standard_input[0]
    $pi1 = standard_input[1]
    $pi2 = standard_input[2]
    $ticks = 10_000

    $step = 1.to_f / $ticks

    init
    proccess
  end

  it 'check failure' do
    clear_variables
    process
    expect(1 - $p_failure.round(2)).to eq(standard_output[0])
  end
  it 'check failure' do
    clear_variables
    process
    expect($channel_load_1.round(2)).to eq(standard_output[1])
  end
  it 'check failure' do
    clear_variables
    process
    expect($channel_load_2.round(2)).to eq(standard_output[2])
  end
  it 'check failure' do
    clear_variables
    process
    expect(($time_in_system.to_f / $ticks).round(2)).to eq(standard_output[3])
  end
end
