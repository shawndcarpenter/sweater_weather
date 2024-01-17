class RouteFinderJob < ApplicationJob
  queue_as :default

  def perform(origin, destination)
    location_service = LocationService.new

    location_service.find_route(origin, destination)
  end
end
