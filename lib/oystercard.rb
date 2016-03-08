require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey_history
  attr_accessor :incomplete_journey

  DEFAULT_BALANCE = 0
  MAX_VALUE = 90
  MAX_VALUE_ERROR = "cannot have balance over #{MAX_VALUE}"
  MIN_VALUE = 1
  MIN_VALUE_ERROR = "balance is less than #{MIN_VALUE}"

  def initialize(balance=DEFAULT_BALANCE)
    @balance = DEFAULT_BALANCE
    @journey_history = []
    @incomplete_journey = nil
  end

  def check_balance
    @balance
  end

  def top_up(value)
    raise MAX_VALUE_ERROR if balance + value > MAX_VALUE
    @balance += value
  end

  def touch_in(station)
    deduct(incomplete_journey.fare) if @incomplete_journey != nil
    #DOES NOT ADD INCOMPLETE JOURNEY TO HISTORY - SHOULD IT BE?
    @incomplete_journey = nil
    raise MIN_VALUE_ERROR if balance < MIN_VALUE
    @incomplete_journey = Journey.new(station)
  end

  def touch_out(station)
    @incomplete_journey.exit_station = station
    @journey_history << { @incomplete_journey.entry_station => @incomplete_journey.exit_station }
    deduct(incomplete_journey.fare)
    @incomplete_journey = nil
  end

    private

    def deduct(value)
      @balance -= value
    end

end
