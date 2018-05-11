def value_or_menu(item)
  case item
    when String then
      if item.include?('https://api')
        url_without_params = remove_parameters(item)
        resp_body = get_resp_body(url_without_params)
        case resp_body
          when Hash then # response has only one element
            create_menu_from_hash(resp_body)
          when Array then # response has more than one elements
            menu_array_hash(resp_body)
        end
      else
        puts item
      end
    when Hash then
      create_menu_from_hash(item)
    else
      puts item
  end
end

def remove_parameters(url)
  url.gsub(/{.*}/,'')
end