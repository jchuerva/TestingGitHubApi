def api_user_menu
  @previous_menu = 'api_user_menu'
  request_user_name
  url = "https://api.github.com/users/#{@user_name}"
  create_menu_from_url(url)
  api_user_menu
end


def request_user_name
  @user_name = '' if @user_name.nil?
  cli = HighLine.new
  # @user_name = cli.ask ("Enter user name"){ |q| q.default = "carlos-testaccount" }
  @user_name = cli.ask ("Enter user name"){ |q| q.default = @user_name }
end