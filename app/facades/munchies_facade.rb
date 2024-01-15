class MunchiesFacade
  def initialize(destination, food)
    @destination = destination
    @food = food
  end

  def munchies
    service = MunchiesService.new
    json = service.get_munchies(@destination, @food)
    # binding.pry
    @business = Business.new(json[:businesses].first)
    binding.pry
  end
end