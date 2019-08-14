require 'uri'
require 'net/https'
require 'net/http'

class ApplicationController < Sinatra::Base
  set :public_folder, 'public'
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

  get '/' do
    erb :index
  end

  post '/' do
    begin
      Validation.new(params[:distribution], params.reject { |key, value| key == 'distribution' } ).validate
    rescue => e
      @exception = e.message
      @exception = 'Введены неправильные параметры' if @exception == 'ArgumentError'
      return erb :error
    end
    distribution = params[:distribution]
    sequence = Services::ApplicationService.check_distribution(distribution).new(params).sequence

    @math_value = sequence.mean
    @dispersion = sequence.variance
    @standard_deviation = sequence.standard_deviation

    graph_hash = Algorithm::Chart.new(sequence).build_chart
    @steps_histogram = graph_hash.keys
    @values_histogram = graph_hash.values

    erb :result
  end
end
