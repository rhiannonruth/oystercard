require "journeylog"

describe JourneyLog do

  let(:journey_class) { double :journey_class, new: journey }
  subject(:journeylog) { described_class.new(journey_class) }
  let(:station) { double :station }
  let(:journey) { double :journey }

  describe "initialization" do
    it "should have an empty journey history" do
      expect(subject.journey_history).to be_empty
    end
  end

  describe "#start_journey" do
    it "should start a journey" do
      expect(journey).to receive(:start)
      subject.start_journey(station)
    end
  end

  describe "#complete_journey" do
    it "should complete a journey" do
      expect(journey).to receive(:complete)
      subject.complete_journey(station)
    end
  end

end
