require 'sinatra/base'
require 'erb'
require 'pry'

Dir['./**/*.rb'].each { |file| load(file) }
map('/') { run ApplicationController }
