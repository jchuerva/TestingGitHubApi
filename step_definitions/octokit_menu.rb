def octokit_menu
  @previous_menu = 'octokit_menu'
  request_user_token

  octokit_submenu
end

def octokit_submenu

  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = "Please choose the user information you want to know"

    menu.choices(:user_information) { pagination; puts "Option selected: User information"; create_octokit_menu('user') }
    menu.choices(:repos_information) { pagination; puts "Option selected: Repository information"; create_octokit_menu('repos') }
    menu.choices(:orgs_information) { pagination; puts "Option selected: Organization information"; create_octokit_menu('orgs') }

    menu.choices(:previous_menu) { main_menu }
    menu.choices(:exit) { abort }
    menu.default = :exit
    pagination
  end
end


def create_octokit_menu(type)

  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = "Please choose the user information you want to know"
    menu.choices(:all_user_information) { pagination; puts "Option selected: All user information"; puts_sawyer_resource(eval(get_submenu(type))) }

    eval(get_submenu(type)).each do |item|
      menu.choice(item[0]) { pagination; puts "Option selected: #{item[0]}"; value_or_menu(item[1]) }
    end

    menu.choices(:previous_menu) { octokit_menu }
    menu.choices(:exit) { abort }
    menu.default = :main_menu
  end
  pagination
  create_octokit_menu(type)
end