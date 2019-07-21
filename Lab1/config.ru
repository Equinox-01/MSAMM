$:.unshift File.expand_path("../", __FILE__)
require 'sinatra/base'
require 'erb'

Dir["./algorithm/*.rb"].each { |file| require file }
require_relative 'controllers/application_controller.rb'
run ApplicationController
