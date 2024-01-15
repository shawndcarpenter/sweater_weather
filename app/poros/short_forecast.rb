class ShortForecast
  attr_reader :summary, :temperature

  def initialize(data)
    @summary = data[:condition][:text]
    @temperature = data[:temp_f]
  end
end