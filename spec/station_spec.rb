require "station"

describe Station do
  subject(:station) {described_class.new(title, zone)}

  describe "initialization" do
    it "should initialize with a name" do
      station = Station.new("Holborn", 1)
      expect(station.title).to eq "Holborn"
    end

    it "should initialize with a zone" do
      station = Station.new("Holborn", 1)
      expect(station.zone).to eq 1
    end
  end


end
