require_relative 'journey'

class JourneyLog

  attr_reader :journey_class, :instantiated_class

  def initialize(journey_class)
    @journey_class = journey_class
  end

  def starting_journey(start_point)
    @instantiated_class = @journey_class.new(start_point)
  end

  def ending_journey(end_point)
    @instantiated_class.finish_journey(end_point)
  end
end
