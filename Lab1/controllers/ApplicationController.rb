require 'uri'
require 'net/https'

class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  get '/' do
    erb :index
  end
end
