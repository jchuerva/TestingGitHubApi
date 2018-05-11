def api_menu(value)
  @previous_menu = "api_menu('#{value}'"
  value == 'user' ? request_user_name : request_org_name
  pagination
  url = value == 'user' ? "https://api.github.com/users/#{@user_name.to_s}" : "https://api.github.com/orgs/#{@org_name.to_s}"
  create_menu_from_url(url)
  api_menu(value)
end

def request_user_name
  @user_name = '' if @user_name.nil?
  cli = HighLine.new
  @user_name = cli.ask('Enter user name') { |q| q.default = @user_name }
end

def request_org_name
  @org_name = '' if @org_name.nil?
  cli = HighLine.new
  @org_name = cli.ask('Enter organization name') { |q| q.default = @org_name }
end
