require_relative "journey"

class JourneyLog

  attr_reader :current_journey

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @current_journey = journey_class.new
    @journey_history = []
  end

  def start_journey(station)
    @current_journey.start(station)
  end

  def complete_journey(station)
    @current_journey.complete(station)
    log
  end

  def journey_history
    @journey_history.dup
  end

  def reset_journey
    @current_journey = @journey_class.new
  end

  def no_touch_out
    @current_journey.no_touch_out
    log
    reset_journey
  end


  private

    def log
      @journey_history << @current_journey
    end

end
