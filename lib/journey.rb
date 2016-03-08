class Journey

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

end
