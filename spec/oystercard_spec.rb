require 'oystercard'

describe Oystercard do

subject(:card) { described_class.new }
let(:max_value) { Oystercard::MAX_VALUE }
let(:min_value) { Oystercard::MIN_VALUE }
let(:entry_station) { double :station }
let(:exit_station) { double :station }

  describe '#initialize' do
    it 'starts with a balance of 0' do
      expect(card.check_balance).to eq 0
    end
    it 'journey_history is empty' do
      expect(card.journey_history).to be_empty
    end
    it 'incomplete_journey is nil' do
      expect(card.incomplete_journey).to be_nil
    end
  end

  describe '#top-up' do
    it 'it should change the balance it was top-uped with' do
      card.top_up(20)
      expect(card.check_balance).to eq 20
    end
    it 'raises error when topped up over the limit' do
      card.top_up(max_value)
      expect { card.top_up(1) }.to raise_error Oystercard::MAX_VALUE_ERROR
    end
  end

  describe '#touch_in' do

    it 'raises an error when balance is less than minimum value' do
      expect{ card.touch_in(entry_station) }.to raise_error Oystercard::MIN_VALUE_ERROR
    end
    it 'creates an instance of a journey' do
      card.top_up(max_value)
      card.touch_in(entry_station)
      expect(card.incomplete_journey).to_not be nil
    end
    it 'deducts balance by fare if there is an incomplete journey' do
      card.top_up(max_value)
      card.touch_in(entry_station)
      allow(card.incomplete_journey).to receive(:fare) {5}
      expect{ card.touch_in(entry_station) }.to change{ card.check_balance }.by(- 5)
    end
  end

  describe '#touch_out' do

    before(:each) { card.top_up(max_value) }

    it 'deducts balance by fare when touching out' do
      card.touch_in(entry_station)
      allow(card.incomplete_journey).to receive(:fare) {5}
      expect{ card.touch_out(exit_station) }.to change{ card.check_balance }.by(- 5)
    end
    it 'resets incomplete_journey back to nil' do
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.incomplete_journey).to be_nil
    end
    it 'contains one journey after touch_in then touch_out' do
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journey_history).to eq([{entry_station => exit_station}])
    end

  end

end
