class Journey

  PENALTY_FARE = 6
  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
    @complete = false
  end

  def start(station)
    @entry_station = station
  end

  def complete(station)
    @exit_station = station
    @complete = true
  end

  def complete?
    @complete
  end

  def fare
    return PENALTY_FARE if penalty?
    Oystercard::MINIMUM_FARE
  end

  private
  
  def penalty?
    (!entry_station || !exit_station)
  end

end
