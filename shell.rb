# require 'httparty'
require 'highline'
require 'octokit'
require 'json'
require 'pry'
require 'faraday'
require 'faraday_middleware'

Dir["step_definitions/*.rb"].each {|file| load file }
# load 'step_definitions/menus.rb'
# load 'step_definitions/comun.rb'


cli = HighLine.new
user_token = cli.ask ("Enter your user token"){ |q| q.default = "bcaae0071b8835971ee07e11e73b4e997242ff06" }

@client = Octokit::Client.new(:access_token => user_token)

user_menu(@client)