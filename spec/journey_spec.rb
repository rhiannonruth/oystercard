require 'journey'

describe Journey do

  subject(:journey) {described_class.new("Victoria")}

  describe '#initialize' do
    it 'starts with an entry station' do
      expect(journey.entry_station).to eq "Victoria"
    end
    it 'does not start with an exit_station' do
      expect(journey.exit_station).to be_nil
    end
  end

  describe '#fare' do
    it 'is MAX_FARE when there is no exit_station' do
      expect(journey.fare).to eq Journey::MAX_FARE
    end
    it 'is MIN_FARE when there is an exit_station' do
      journey.exit_station = "Bank"
      expect(journey.fare).to eq Journey::MIN_FARE
    end
  end

end
