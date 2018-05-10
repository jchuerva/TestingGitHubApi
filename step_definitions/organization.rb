def org_menu
  @previous_menu = 'org_menu'
  request_org_name
  url = "https://api.github.com/orgs/#{@org_name}"
  create_menu_from_url(url)
  org_menu
end

def puts_value_or_url(item)
  if item.include?('https://api')
    url_without_params = remove_parameters(item)
    resp_body = get_resp_body(url_without_params)
    menu_id_name_results(resp_body)
  else
    puts item
  end
end

def request_org_name
  cli = HighLine.new
  @org_name = cli.ask ("Enter organization name"){ |q| q.default = "carlos-organization" }
end