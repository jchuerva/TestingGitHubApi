def create_menu_from_url(url_to_menu)
  @api_response = get_resp_body(url_to_menu)
  puts "##### API Response class: #{@api_response.class}"

  create_menu_from_hash(@api_response)
end

def create_menu_from_hash(cadena_hash)
  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = "Please choose the user information you want to know"

    menu.choices(:all_org_information) { pagination; puts "Option selected: All org information"; binding.pry; puts cadena_hash; continue }

    cadena_hash.each_with_index do |item, index|
      menu.choice(item[0]) {pagination; puts "Option selected: #{item[0]}"; value_or_menu(item[1]); continue}
    end
    menu.choices(:previous_menu) { eval(@previous_menu) }
    menu.choices(:exit) { abort }
    menu.default = :exit
  end
end

def value_or_menu(item)
  # es una url. Hay q abrirla y crear el menu
  if item.class == String && item.include?('https://api')
    url_without_params = remove_parameters(item) # quitar parametros de la url
    resp_body = get_resp_body(url_without_params) # obtener la respuesta como Hash o Array de Hash
    menu_array_hash(resp_body) # crear menu a partir de la respuesta

  # es un hash y hay q crear el menu
  elsif item.class == Hash
    menu_hash(item)

  # es un valor
  else
    puts item
  end
end

# hay q pintar solo el title|id|name de cada resultado xq es un Array de Hash
# una vez q se seleccione, se
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
      menu.choice(:all_info) { pagination; puts "Option selected: All information"; binding.pry; puts array_of_hash; continue }
    end
    menu.choices(:previous_menu) { eval(@previous_menu) }
    menu.choices(:exit) { abort }
    menu.default = :exit
  end
end

def name_elements_resp(response)
  response.map { |item| item[:name] || item[:login] || item[:id] || item['name'] || item['login'] || item['id'] }
end