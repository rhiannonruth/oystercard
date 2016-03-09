require_relative "journey"

class JourneyLog

  attr_reader :current_journey

  def initialize(journey = Journey)
    @journey = journey
    @current_journey = journey.new
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
    @current_journey = @journey.new
  end

  private

    def log
      @journey_history << @current_journey
    end

end
