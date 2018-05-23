class GitHubFaradayResponse 
  def initialize(value)
      @name = value
   end

  def base
    base_url = 'https://api.github.com/'
    Faraday.new(url: base_url) do |faraday|
      faraday.response :json, parser_options: { symbolize_names: false }
      faraday.adapter Faraday.default_adapter
    end
  end

  def users
    binding.pry
    base.get("users/#{@name}").body
  end

  def orgs
    base.get("/orgs/#{@name}").body
  end
end