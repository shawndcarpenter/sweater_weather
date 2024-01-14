class MunchiesService
  def conn
    Faraday.new(url: "https://api.yelp.com/v3/businesses/search") do |faraday|
      faraday.headers["key"] = Rails.application.credentials.yelp[:key]
    end
  end

  def get_munchies(destination, food)
    response = conn.get("?location=#{location}&category=#{food}&term=restaurants")
    JSON.parse(response.body, symbolize_names: true)
  end
end