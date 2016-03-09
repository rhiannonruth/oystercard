require_relative "journey"
require_relative "station"

class Oystercard

  MAXIMUM_BALANCE = 90
  MAXIMUM_BALANCE_ERROR = "Maximum balance of #{MAXIMUM_BALANCE} exceeded"
  MINIMUM_BALANCE = 1
  MINIMUM_BALANCE_ERROR = "Balance under #{MINIMUM_BALANCE}"
  attr_reader :balance

  def initialize(journeylog:JourneyLog)
    @balance = 0
  end

  def top_up(amount)
    raise MAXIMUM_BALANCE_ERROR if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise MINIMUM_BALANCE_ERROR if @balance < MINIMUM_BALANCE
    start_journey(station)
    # no_touch_out if @journey.entry_station != nil && @journey.exit_station == nil
    # @journey.start(station)
  end

  def touch_out(station)
    # @journey.complete(station)
    # deduct(@journey.fare)
    # log
    # @journey = Journey.new
  end

  private

    def deduct(amount)
      @balance -= amount
    end

    def no_touch_out
      # deduct(@journey.fare)
      # @journey.no_touch_out
      # log
      # @journey = Journey.new
    end

    # def log
    #   @journey_history << @journey
    # end

end
