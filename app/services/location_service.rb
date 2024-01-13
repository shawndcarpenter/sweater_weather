class LocationService
  def conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/address") do |faraday|
      faraday.headers["key"] = Rails.application.credentials.map_quest[:key]
    end
  end

  def find_lat_and_lon(location)
    response = conn.get("?location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end
end