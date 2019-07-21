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

    graph_hash = Algorithm::Chart.new(sequence).build_chart
    @steps_histogram = graph_hash.keys
    @values_histogram = graph_hash.values

    stats = Algorithm::Stats.new(sequence)
    @math_value = stats.expected
    @dispersion = stats.dispersion
    @standard_deviation = stats.standard_deviation
    @indirect_indications = stats.indirect_evaluation
    @period_length = stats.period_length
    @aperiodic_section_length = stats.aperiodicity

    erb :result
  end
end
