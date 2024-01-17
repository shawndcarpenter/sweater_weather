class GeolocationFacade
  def initialize(location)
    @location = location
  end

  def geocode
    service = LocationService.new
    json = service.find_lat_and_lon(@location)

    if location_invalid?(json)
      ErrorMessage.new("No locations found", 422)
    else
      Geocode.new(json)
    end
  end

  private
  def location_invalid?(json)
    json[:info][:statuscode] == 400 || 
    json[:results].first[:locations].first[:adminArea5] == ""
  end
end