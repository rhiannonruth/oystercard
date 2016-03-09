class Journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 1
  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
    @complete = false
  end

  def start(station)
    no_touch_out
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
    MINIMUM_FARE
  end

  def no_touch_out
    @exit_station = "Did not touch out" if entry_station != nil && exit_station == nil
  end

  private

  def penalty?
    (!entry_station || !exit_station)
  end

end
