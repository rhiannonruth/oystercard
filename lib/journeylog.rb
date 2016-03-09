require_relative "journey"

class JourneyLog

  def initialize(current_journey=Journey.new)
    @current_journey = current_journey
    @journey_history = []
  end

  def start_journey(station)
    @current_journey.start(station)
  end

  def complete_journey(station)
    @current_journey.complete(station)
  end

  def journey_history
    @journey_history.dup
  end

  private

    def log
      @journey_history << @current_journey
    end

end
