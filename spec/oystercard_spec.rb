require 'oystercard'

describe Oystercard do

  # default_value = Oystercard::DEFAULT_BALANCE
  maximum = Oystercard::MAXIMUM
  minimum = Oystercard::MINIMUM
  minimum_fare = Oystercard::MINIMUM_FARE
  penalty_fare = Oystercard::PENALTY_FARE

  subject(:card) { described_class.new }
  let (:entry_station)  { double :station }
  let (:exit_station)   { double :station }

  describe '#initialize' do
    it 'starts with a balance of 0' do
      expect(card.balance).to be_zero
    end
    it 'starts with in_journey set to false' do
      expect(card.in_journey?).to eq false
    end
    it 'starts with an emptry journey history' do
      expect(card.journeys).to be_empty
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
      expect{ card.top_up(amount) }.to change{ card.balance }.by (amount)
    end

    it 'raise an error when trying to exceed balance maximum' do
      amount = maximum+1
      message = "cannot exceed maximum amount £#{maximum}"
      expect{ card.top_up(amount) }.to raise_error message
    end
  end

  describe '#touch_in' do

    before do
      card.top_up(maximum)
      card.touch_in(entry_station)
    end

    it 'charges penalty_fare when touching in twice' do
      expect{ card.touch_in(entry_station) }.to change{ card.balance }.by(-penalty_fare)
    end

    it 'adds entries to journeys array when touching in twice' do
      card.touch_in(entry_station)
      test_journey = { :entry_station => entry_station, :exit_station => nil }
      expect(card.journeys).to include(test_journey)
    end

    it 'sets in_journey to true' do
      expect(card.in_journey?).to eq true
    end

    it 'raises an error when balance is below minimum' do
      card = described_class.new(0)
      expect{ card.touch_in(entry_station) }.to raise_error 'insufficient funds.'
    end

    it 'should set value of entry_station' do
      expect(card.entry_station).to eq(entry_station)
    end

  end

  describe '#touch_out' do

    before do
      card.top_up(maximum)
      card.touch_in(entry_station)
    end

    it 'charges maximum fare when entry_station is unknown' do
      card = described_class.new(0)
      card.top_up(maximum)
      expect{ card.touch_out(exit_station) }.to change{ card.balance }.by(-penalty_fare)
    end


    it 'changes in_journey status to false' do
      card.touch_out(exit_station)
      expect(card.in_journey?).to eq false
    end

    it 'charges minimum fare' do
      expect{card.touch_out(exit_station) }.to change{ card.balance}.by(-minimum_fare)
    end

    it 'resets entry_station to nil' do
      card.touch_out(exit_station)
      expect(card.entry_station).to eq nil
    end

    it 'pushes entry/exit hash into journeys array' do
      card.touch_out(exit_station)
      test_journey = { :entry_station => entry_station, :exit_station => exit_station }
      expect(card.journeys).to include(test_journey)
    end

  end

end
