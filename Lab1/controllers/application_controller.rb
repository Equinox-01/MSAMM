require 'uri'
require 'net/https'

class ApplicationController < Sinatra::Base
  set :public_folder, 'public'
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

  get '/' do
    erb :index
  end

  post '/' do
    a = params[:a].to_i
    r0 = params[:R0].to_i
    m0 = params[:m0].to_i
    sequence = Algorithm::Lehmer.new(a, m0, r0).sequence
    graph_hash = Algorithm::Chart.build_chart(sequence)
    @steps_histogram = []
    @values_histogram = []
    graph_hash.each_with_index { |key, value| @steps_histogram << key; @values_histogram << value }

    @steps_histogram = graph_hash.keys
    @values_histogram = graph_hash.values

    stats = Algorithm::Stats.new(sequence)
    @math_value = stats.instance_variable_get(:@expected)
    @dispersion = stats.instance_variable_get(:@dispersion)
    @standard_deviation = stats.instance_variable_get(:@standardDeviation)
    @indirect_indications = stats.instance_variable_get(:@indirectEvaluation)
    @period_length = stats.instance_variable_get(:@period_length)
    @aperiodic_section_length = stats.instance_variable_get(:@aperiodicity)

    erb :result
  end
end
