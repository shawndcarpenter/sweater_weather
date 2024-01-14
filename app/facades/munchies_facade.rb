class MunchiesFacade
  def initialize(destination, food)
    @destination = destination
    @food = food
  end

  def munchies
    service = MunchiesService.new
    json = service.find_munchies(@destination, @food)
    
    @business = Business.new(json[:businesses].first)
  end
end