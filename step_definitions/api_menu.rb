def api_menu(value)
  @previous_menu = "api_menu('#{value}'"
  value == 'user' ? request_user_name : request_org_name
  pagination

  create_menu_from_url(value)
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
