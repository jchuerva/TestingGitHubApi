def user_menu(client)
  cli = HighLine.new
  cli.choose do |menu|
    menu.prompt = "Please choose the user information you want to know"
    menu.choices(:all_user_information) { puts_hash(client.user) }

    client.user.each do |item|
      menu.choice(item[0]) { open_value(client.user, item) }
    end
    menu.choices(:exit) { abort }
    menu.default = :exit
  end
pagination
  user_menu(client)
end

def open_value(cadena, item)
  # it's a url
  if get_value(item).include?('https://api')
    url = cadena[get_key(item)]
    # check if url has parameters
    # binding.pry
    parms = url_params(url) if include_param?(url)
    # remove parameters
    url_without_params = remove_parameters(url)
    # request get 
    resp_body = get_url(url_without_params)
    create_menu_elements(resp_body)
  
      # it's not an url
  else
    puts "User #{get_key(item)}: #{cadena[get_key(item)]}"
  end
end

def include_param?(url)
  url.match?(/{.*}/)
end

def remove_parameters(url)
  url.gsub(/{.*}/,'')
end

def url_params(url)
  url.match(/{.*}/)
end

def get_elements_response(response)
  response.map { |item| item[:name] || item[:login] || item[:id] }
end

def create_menu_elements(resp_body)
  # binding.pry
  cli = HighLine.new
    cli.choose do |menu|
    menu.prompt = "Please choose the user information you want to know"
    get_elements_response(resp_body).each_with_index do |item, index|
      # binding.pry
      menu.choice(item) {puts_hash(resp_body[index]); pagination; create_menu_elements(resp_body)}
    end
    menu.choices(:previous_menu) { pagination; user_menu(@client) }
    menu.choices(:exit) { abort }
  end
end


def get_url(purl)
  conn = Faraday.new(url: purl) do |faraday|
    Faraday.token_auth('bcaae0071b8835971ee07e11e73b4e997242ff06')
    faraday.adapter Faraday.default_adapter
    faraday.response :json, :parser_options => { :symbolize_names => true } 
  end
 
  response = conn.get()
  return response.body
end

def number_elm_reponse(resp)
  resp.count
end