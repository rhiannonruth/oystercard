require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:station) { double :station }
  let(:destination) { double :destination }

  it "is incomplete when initialized" do
    expect(subject).not_to be_complete
  end

  describe "#start_journey" do
    it "records an entry station when touched in" do
      subject.start(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe "#complete_journey" do
    before do
      subject.complete(destination)
    end

    it "records an exit station when touched out" do
      expect(subject.exit_station).to eq destination
    end

    it "changes journey status to complete" do
      expect(subject).to be_complete
    end
  end

  describe "#fare" do
    it "has a penalty fare when incomplete" do
      expect(subject.fare).to eq described_class::PENALTY_FARE
    end

    it "returns a fare upon touch-out" do
      subject.start(station)
      subject.complete(destination)
      expect(subject.fare).to eq Oystercard::MINIMUM_FARE
    end
  end

end
