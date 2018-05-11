def api_org_menu
  @previous_menu = 'api_org_menu'
  request_org_name
  url = "https://api.github.com/orgs/#{@org_name}"
  create_menu_from_url(url)
  api_org_menu
end

def request_org_name
  @org_name = '' if @org_name.nil?
  cli = HighLine.new
  # @org_name = cli.ask ("Enter organization name"){ |q| q.default = "carlos-organization" }
  @org_name = cli.ask ("Enter organization name"){ |q| q.default = @org_name }
end