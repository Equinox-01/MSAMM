require 'sinatra/base'
require 'erb'
require 'pry'
require 'pry-nav'

Dir['./**/*.rb'].each { |file| load(file) }
map('/') { run ApplicationController }
