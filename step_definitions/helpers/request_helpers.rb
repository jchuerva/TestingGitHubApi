def request_user_token
  @user_token = '' if @user_token.nil? || !@valid_user_token
  cli = HighLine.new
  @user_token = cli.ask('Enter your user token') { |q| q.default = @user_token }

  generate_client(@user_token)
end

def generate_client(token)
  @client = Octokit::Client.new(access_token: token)
end

def get_submenu(type)
  "@client.#{type}"
end
