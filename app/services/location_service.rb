class LocationService
  def conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/address") do |faraday|
      faraday.headers["key"] = Rails.application.credentials.map_quest[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def find_lat_and_lon(location)
    get_url("?location=#{location}")
  end
end