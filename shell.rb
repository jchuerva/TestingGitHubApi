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
user_token = cli.ask ("Enter your user token"){ |q| q.default = "54156538972325b0d8ce5a7126b972e671744630" }

client = Octokit::Client.new(:access_token => user_token)

user_menu(client)

