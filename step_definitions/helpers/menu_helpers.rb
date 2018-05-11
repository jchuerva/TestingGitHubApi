def create_menu_from_url(url_to_menu)
  @api_response = get_resp_body(url_to_menu)

  create_menu_from_hash(@api_response)
end

def create_menu_from_hash(cadena_hash)
  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = "Please choose the user information you want to know"

    menu.choices(:all_information) { pagination; puts "Option selected: All nformation"; pretty_format(cadena_hash); continue }

    cadena_hash.each_with_index do |item, index|
      menu.choice(item[0]) {pagination; puts "Option selected: #{item[0]}"; value_or_menu(item[1]); continue}
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
    menu.prompt = "Please choose the user information you want to know"
    menu_element.each_with_index do |item, index|
      menu.choice(item) {
        pagination;
        puts "Option selected: #{item}";
        value_or_menu(array_of_hash[index]);
        continue
      }
      end
    menu.choice(:all_info) { pagination; puts "Option selected: All information"; puts array_of_hash; continue }
    menu.choices(:previous_menu) { eval(@previous_menu) }
    menu.choices(:exit) { abort }
    menu.default = :exit
  end
  menu_array_hash(array_of_hash)
end

def name_elements_resp(response)
  response.map { |item| item['name'] || item['login'] || item['id'] }
end