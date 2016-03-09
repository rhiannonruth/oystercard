require 'oystercard'

describe Oystercard do

  # default_value = Oystercard::DEFAULT_BALANCE
  maximum = Oystercard::MAXIMUM
  minimum = Oystercard::MINIMUM
  minimum_fare = Oystercard::MINIMUM_FARE

  subject(:card) { described_class.new }
  let (:entry_station)  { double :station }

  describe '#initialize' do
    it 'initializes with a balance' do
      expect(card.balance).to be_integer
    end

    it 'is created with in_journey attribute: false' do
      expect(card.in_journey?).to eq false
    end

    it 'is initialized with an entry station (nil)' do
      expect(card.entry_station).to eq nil
    end

  end

  describe '#top_up' do
    # it 'adds amount to existing balance' do
    #   prev_balance = card.balance
    #   amount = rand(1..20)
    #   card.top_up(amount)
    #   expect(card.balance).to eq(prev_balance + amount)
    # end
    it "adds amount to existing balance 2.0" do
      amount = rand(1..20)
      expect{card.top_up(amount)}.to change{card.balance}.by (amount)
    end

    it 'raise an error' do
      prev_balance = card.balance
      amount = rand((90 - prev_balance)..100)
      message = "cannot exceed maximum amount £#{maximum}"
      expect{card.top_up(amount)}.to raise_error message
    end
  end

  describe '#in_journey?' do
    it 'reveals whether the card is in journey (touched in)' do
      expect(card.in_journey?).to eq false
    end
  end

  describe '#touch_in' do

    before do
      card.top_up(Oystercard::MINIMUM)
    end

    it 'changes touched_in to true' do
      card.touch_in(entry_station)
      expect(card.in_journey?).to eq true
    end

    it 'raises an error when balance is below minimum' do
      card = described_class.new(0)
      expect{card.touch_in(entry_station)}.to raise_error 'insufficient funds.'
    end


    it 'remembers station of entry' do
      card.touch_in(entry_station)
      expect(card.entry_station).to eq(entry_station)
    end

  end

  describe '#touch_out' do

    before do
      card.top_up(Oystercard::MINIMUM)
    end

    it 'changes touched_in to false' do
      card.touch_in(entry_station)
      card.touch_out
      expect(card.in_journey?).to eq false
    end

    it {expect{card.touch_out}.to change{card.balance}.by(-minimum_fare)}

    it 'resets entry_station to nil' do
      card.touch_in('Bank')
      card.touch_out
      expect(card.entry_station).to eq nil
    end
  end

end
