
def user_menu(client)
  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = "Please choose the user information you want to know"
    menu.choices(:all_user_information) { puts_hash(client.user) }

    client.user.each do |item|
      # menu.choice(key) { puts "User #{key.to_s}: #{client.user[key.to_s]}" }
      # menu.choice(key) { check_if_http(client.user, value.to_s) }
      menu.choice(item[0]) { open_value(client.user, item) }
    end
    menu.choices(:exit) { abort }
    menu.default = :exit
  end
  puts " "
  puts "#######"
  puts " "
  # user_menu(client)
end

def open_value(cadena, item)
  if get_value(item).include?('https://')
    get_url(cadena[get_key(item)])
  else
    puts "User #{get_key(item)}: #{cadena[get_key(item)]}"
  end
end

def get_url(purl)
  conn = Faraday.new(url: purl) do |faraday|
    faraday.adapter Faraday.default_adapter
    faraday.response :json
  end
 
  binding.pry
  response = conn.get()
  response.body
end
