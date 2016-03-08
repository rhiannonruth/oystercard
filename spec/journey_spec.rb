require 'journey'

describe Journey do
  subject(:journey) {described_class.new}



  it {is_expected.to respond_to :make_journey}
  describe "#make_journey" do
    it "should pass entry and exit stations into the hash" do
      subject.start_journey(:bond_st)
      subject.complete_journey(:oxford_st)
      expect(subject.make_journey).to eq ({entry_station: :bond_st, exit_station: :oxford_st})
    end
  end

  describe "#start_journey" do
    it "should update the entry station" do
      subject.start_journey(:bond_st)
      expect(subject.entry_station).to eq :bond_st
    end
  end

  describe "#complete_journey" do
    it "should update the exit station" do
      subject.complete_journey(:oxford_st)
      expect(subject.exit_station).to eq :oxford_st
    end
  end

  it {is_expected.to respond_to :entry_station}
  it {is_expected.to respond_to :exit_station}
end
