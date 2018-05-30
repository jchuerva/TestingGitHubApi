def get_faraday
   base_url = 'https://api.github.com/'
   Faraday.new(url: base_url) do |faraday|
     faraday.response :json, parser_options: { symbolize_names: false }
     faraday.adapter Faraday.default_adapter
   end
 end