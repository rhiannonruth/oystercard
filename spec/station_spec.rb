require 'station'

describe Station do

  let(:name) {"Victoria"}
  let(:zone) {1}
  subject(:station) { described_class.new(name,zone) }

  describe '#initialize' do
    it 'sets name value' do
      expect(station.name).to eq(name)
    end
    it 'sets zone value' do
      expect(station.zone).to eq(zone)
    end
  end

end
