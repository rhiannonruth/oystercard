require "station"

describe Station do
  subject(:station) {described_class.new(title, zone)}

  describe "initialization" do
    it "should initialize with a name" do
      station = Station.new(:bond_st, 1)
      expect(station.title).to eq :bond_st
    end

    it "should initialize with a zone" do
      station = Station.new(:bond_st, 1)
      expect(station.zone).to eq 1
    end
  end


end
