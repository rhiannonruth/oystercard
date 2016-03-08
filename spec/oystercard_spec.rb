require 'oystercard'

describe Oystercard do

subject(:card) { described_class.new }
let(:max_value) { Oystercard::MAX_VALUE }
let(:min_value) { Oystercard::MIN_VALUE }
let(:entry_station) { double :station }
let(:exit_station) { double :station }

  describe '#balance' do
    it 'starts with a balance of 0' do
      expect(card.check_balance).to eq 0
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

  # describe '#in_journey' do
  #
  #   before(:each) { card.top_up(max_value) }
  #
  #   it 'touch_in changes in_journey? status to true' do
  #     card.touch_in(entry_station)
  #     expect(card).to be_in_journey
  #   end
  #   it 'touch_out changes in_journey? status to false' do
  #     card.touch_out(exit_station)
  #     expect(card).to_not be_in_journey
  #   end
  # end

  describe '#touch_in' do

    it 'raises an error when balance is less than minimum value' do
      expect{ card.touch_in(entry_station) }.to raise_error Oystercard::MIN_VALUE_ERROR
    end
    it 'creates an instance of a journey' do
      card.top_up(max_value)
      card.touch_in(entry_station)
      expect(card.incomplete_journey).to_not be nil
    end
  end

  describe '#touch_out' do

    before(:each) { card.top_up(max_value) }

    it 'deducts balance when touching out' do
      card.touch_in(entry_station)
      expect{ card.touch_out(exit_station) }.to change{ card.check_balance }.by(- min_value)
    end
    it 'resets incomplete_journey back to nil' do
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.incomplete_journey).to be_nil
    end

  end

  describe '#journey_history' do

    before(:each) { card.top_up(max_value) }

    it 'is empty on initialize' do
      expect(card.journey_history).to be_empty
    end
    it 'contains one journey after touch_in then touch_out' do
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journey_history).to eq([{entry_station => exit_station}])
    end
  end

end
