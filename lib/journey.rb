class Journey

  attr_reader :entry_station, :exit_station, :journey

  def start_journey(station)
    @entry_station = station
    #@journey = {entry_station: entry_station, exit_station: exit_station}
  end

  def complete_journey(station)
    @exit_station = station
    #@journey = {entry_station: entry_station, exit_station: exit_station}
  end

  def update_journey
    @journey = {entry_station: entry_station, exit_station: exit_station}
  end

  def no_touch_in?
    @entry_station == nil
  end

  def no_touch_out?
    @entry_station != nil
  end

  # def make_journey
  #   {entry_station: @entry_station, exit_station: @exit_station}
  #
  # end


end
