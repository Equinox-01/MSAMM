$:.unshift File.expand_path("../", __FILE__)
require 'sinatra/base'
require 'descriptive_statistics'
require 'erb'

Dir["./algorithm/*.rb"].each { |file| require file }
Dir["./algorithm/distributions/*.rb"].each { |file| require file }
Dir["./services/*.rb"].each { |file| require file }
Dir["./controllers/*.rb"].each { |file| require file }

require_relative 'validation.rb'
run ApplicationController
