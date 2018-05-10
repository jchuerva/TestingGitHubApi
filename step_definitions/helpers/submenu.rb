def create_menu_elements(resp_body)
  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = "Please choose the user information you want to know"
    name_elements_resp(resp_body).each_with_index do |item, index|
      menu.choice(item) { pagination; puts "Option selected: #{item}"; pagination; puts_sawyer_resource(resp_body[index]); continue; create_menu_elements(resp_body) }
    end
    menu.choices(:previous_menu) { pagination; user_menu(@client) }
    menu.choices(:exit) { abort }
  end
end

# menu id/name de resultados para hash
def menu_id_name_results(resp_body)
  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = "Please choose the user information you want to know"

    name_elements_resp(resp_body).each_with_index do |item, index|
      menu.choice(item) { 1
      pagination;
      puts "Option selected: #{item}";
      puts resp_body[index]
      continue
      }
    end
    menu.choices(:exit) { abort }
  end
end




def get_resp_body(purl)
  conn = Faraday.new(url: purl) do |faraday|
    Faraday.token_auth(@user_token)
    faraday.response :json, :parser_options => { :symbolize_names => false }
    faraday.adapter Faraday.default_adapter
  end

  response = conn.get()
  response.body
end


def menu_hash(cadena_hash)
  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = "Please choose the user information you want to know"

    menu.choices(:all_org_information) { pagination; puts "Option selected: All org information"; puts JSON.pretty_generate(cadena_hash); continue }

    cadena_hash.each_with_index do |item, index|
      menu.choice(item[0]) { pagination; puts "Option selected: #{item[0]}"; value_or_menu(item[1]); continue }
    end
    menu.choices(:previous_menu) { pagination; user_menu(@client) }
    menu.choices(:exit) { abort }
  end
end