class GeolocationFacade
  def initialize(location)
    @location = location
  end

  def geocode
    service = LocationService.new
    json = service.find_lat_and_lon(@location)

    if json[:results].first[:locations].first[:adminArea5] == ""
      @geocode = ErrorMessage.new("No locations found", 422)
    else
      @geocode = Geocode.new(json)
    end
  end
end