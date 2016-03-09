require 'oystercard'

describe Oystercard do

  # default_value = Oystercard::DEFAULT_BALANCE
  maximum = Oystercard::MAXIMUM
  minimum = Oystercard::MINIMUM
  minimum_fare = Oystercard::MINIMUM_FARE

  subject(:card) { described_class.new }
  let (:entry_station)  { double :station }
  let (:exit_station)   { double :station }

  describe '#initialize' do
    it {expect(card.balance).to be_integer}
    it {expect(card.in_journey?).to eq false}
    it {expect(card.journeys).to be_empty}
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
      amount = maximum+1
      message = "cannot exceed maximum amount £#{maximum}"
      expect{card.top_up(amount)}.to raise_error message
    end
  end

  describe '#in_journey?' do
    it {expect(card.in_journey?).to eq false}
  end

  describe '#touch_in' do
    before do
      card.top_up(Oystercard::MINIMUM)
      card.touch_in(entry_station)
    end

    it {expect(card.in_journey?).to eq true}

    it 'raises an error when balance is below minimum' do
      card = described_class.new(0)
      expect{card.touch_in(entry_station)}.to raise_error 'insufficient funds.'
    end

    it {expect(card.entry_station).to eq(entry_station)}
  end

  describe '#touch_out' do
    before do
      card.top_up(Oystercard::MINIMUM)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
    end

    it {expect(card.in_journey?).to eq false}

    it {expect{card.touch_out(exit_station)}.to change{card.balance}.by(-minimum_fare)}

    it {expect(card.entry_station).to eq nil}

    it 'pushes entry/exit hash into journeys array' do
      test_journey = {:entry_station => entry_station, :exit_station => exit_station }
      expect(card.journeys).to include(test_journey)
    end

    it {expect(card.journeys.length).to eq 1}
  end



end
