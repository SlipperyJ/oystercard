class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  UNRECORDED_STATION = "Unknown"
  attr_reader :entry_station, :exit_station

  def initialize(entry_station = UNRECORDED_STATION)
    @entry_station = entry_station
  end

  def finish_journey(exit_station = UNRECORDED_STATION)
    @exit_station = exit_station
    self
  end

  def complete?
   true unless !!entry_station && exit_station == nil
  end

  def fare
    if entry_station == UNRECORDED_STATION|| exit_station == UNRECORDED_STATION
      PENALTY_FARE
    else
      MINIMUM_FARE
    end
  end
end
