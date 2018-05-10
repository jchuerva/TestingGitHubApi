# require 'httparty'
require 'highline'
require 'octokit'
require 'json'
require 'pry'
require 'faraday'
require 'faraday_middleware'

Dir["step_definitions/*.rb"].each {|file| load file }
Dir["step_definitions/helpers/*.rb"].each {|file| load file }

def main_menu
  @previous_menu = 'main_menu'
  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = "Please choose the user information you want to know"

    menu.choices(:user_information_api) { pagination; puts "Option selected: User information"; request_user_token; user_menu(@client) }
    menu.choices(:org_information_api) { pagination; puts "Option selected: Organization information"; org_menu }
    # menu.choices(:user_information_octokit) { pagination; puts "Option selected: User information"; request_user_token; user_menu(@client) }
    menu.choices(:exit) { abort }
    menu.default = :exit
  end
end

main_menu