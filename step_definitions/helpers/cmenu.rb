def open_value(cadena, item)
  # it's a url
  if get_value(item).include?('https://api')
    url = cadena[get_key(item)]
    # check if url has parameters
    parms = url_params(url) if include_param?(url)
    # remove parameters
    url_without_params = remove_parameters(url)
    # request get 
    resp_body = (url_without_params)
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