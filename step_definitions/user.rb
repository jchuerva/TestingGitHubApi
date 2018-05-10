def user_menu(client)
  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = "Please choose the user information you want to know"
    menu.choices(:all_user_information) { pagination; puts "Option selected: All user information"; puts_sawyer_resource(client.user) }

    client.user.each do |item|
      menu.choice(item[0]) { pagination; puts "Option selected: #{item[0]}"; open_value(client.user, item) }
    end
    menu.choices(:main_menu) { main_menu }
    menu.choices(:exit) { abort }
    menu.default = :main_menu
  end
  continue
  user_menu(client)
end

def request_user_token
  cli = HighLine.new
  @user_token = cli.ask ("Enter your user token"){ |q| q.default = "bcaae0071b8835971ee07e11e73b4e997242ff06" }

  generate_client(@user_token)
  pagination
end

def generate_client(token)
  @client = Octokit::Client.new(:access_token => token)
end