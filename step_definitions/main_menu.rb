def main_menu
  @previous_menu = 'main_menu'
  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = "Please choose the user information you want to know"

    menu.choices(:user_information_api) { pagination; puts "Option selected: User information"; api_user_menu }
    menu.choices(:org_information_api) { pagination; puts "Option selected: Organization information"; api_org_menu }

    menu.choices(:octokit) { pagination; puts "Option selected: Ocktokit"; octokit_menu }

    menu.choices(:exit) { abort }
    menu.default = :exit
    pagination
  end
end