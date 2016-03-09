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
    no_touch_out if entry_station != nil && exit_station == nil
    @entry_station = station
  end

  def complete(station)
    no_touch_in if entry_station == nil
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

  def no_touch_in
    @entry_station = "Did not touch in"
  end

  def no_touch_out
    @exit_station = "Did not touch out"
  end

  private

  def penalty?
    (!entry_station || !exit_station)
  end

end
