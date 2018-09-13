require 'uri'
require 'net/https'

class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  get '/' do
    erb :index
  end

  post '/' do
    # Enter input data
    a = params[:a]
    r0 = params[:r0]
    m0 = params[:m0]
    # Proccessing module
    
    # Output data
    @returnings_value = []  # Array.new(21) { rand(100...3000) }
    @math_value = 0
    @dispersion = 0
    @standard_deviation = 0
    @indirect_indications = 0
    @period_length = 0
    @aperiodic_section_length = 0
    erb :result
  end
end
