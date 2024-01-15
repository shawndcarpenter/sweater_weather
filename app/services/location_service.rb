class LocationService
  def conn
    Faraday.new(url: "https://www.mapquestapi.com/") do |faraday|
      faraday.headers["key"] = Rails.application.credentials.map_quest[:key]
    end
  end

  def find_lat_and_lon(location)
    response = conn.get("geocoding/v1/address?location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def find_route(origin, destination)
    response = conn.get("directions/v2/route?from=#{origin}&to=#{destination}")
    JSON.parse(response.body, symbolize_names: true)
  end
end