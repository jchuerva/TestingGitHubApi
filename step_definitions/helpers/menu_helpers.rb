def create_menu_from_url(value)
  create_menu_from_hash(api_response(value))
end

def api_response(value)
  case value
  when 'user' then
    get_faraday.get("/users/#{@user_name}").body
    # GitHubFaradayResponse.new(@user_name).users
  when 'org' then
    get_faraday.get("/orgs/#{@org_name}").body
    # GitHubFaradayResponse.new(@org_name).orgs
  else
    get_faraday.get(value).body
  end
end

def create_menu_from_hash(cadena_hash)
  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = 'Please choose the user information you want to know'

    menu.choices(:all_information) do
      pagination
      puts 'Option selected: All information'
      pretty_format(cadena_hash)
      continue
    end

    cadena_hash.each_with_index do |item, _index|
      menu.choice(item[0]) do
        pagination
        puts "Option selected: #{item[0]}"
        value_or_menu(item[1])
        continue
      end
    end
    menu.choices(:previous_menu) { main_menu }
    menu.choices(:exit) { abort }
    menu.default = :exit
  end
  create_menu_from_hash(cadena_hash)
end

def menu_array_hash(array_of_hash)
  menu_element = name_elements_resp(array_of_hash)

  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = 'Please choose the user information you want to know'
    menu_element.each_with_index do |item, index|
      menu.choice(item) do
        pagination
        puts "Option selected: #{item}"
        value_or_menu(array_of_hash[index])
        continue
      end
    end
    menu.choice(:all_info) do
      pagination
      puts 'Option selected: All information'
      puts array_of_hash
      continue
    end
    menu.choices(:previous_menu) { eval(@previous_menu) }
    menu.choices(:exit) { abort }
    menu.default = :exit
  end
  menu_array_hash(array_of_hash)
end

def name_elements_resp(response)
  response.map { |item| item['name'] || item['login'] || item['id'] || item[:name] || item[:login] || item[:id]}
end