require 'highline'
require 'octokit'
require 'json'
require 'pry'
require 'faraday'
require 'faraday_middleware'

Dir["step_definitions/*.rb"].each {|file| load file }
Dir["step_definitions/helpers/*.rb"].each {|file| load file }

main_menu