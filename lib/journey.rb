class Journey

  attr_reader :entry_station
  attr_accessor :exit_station

  MIN_FARE = 1
  MAX_FARE = 6

  def initialize(station)
    @entry_station = station
    @exit_station = nil
  end

  def fare
    exit_station == nil ? MAX_FARE : MIN_FARE
  end

end
