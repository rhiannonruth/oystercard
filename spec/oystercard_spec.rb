require 'oystercard'

describe Oystercard do
  #let(:journey) { double :journey, complete: nil, fare: 1}
  subject(:oystercard) { described_class.new }
  let(:station) { double :station }
  let(:exit_station) { double :station }

  describe "initialization" do
    it 'is initialized with a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "should top up card by specified amount" do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by(10)
    end

    it "should raise an error if maximum balance exceeded" do
      amount = Oystercard::MAXIMUM_BALANCE + 1
      message = Oystercard::MAXIMUM_BALANCE_ERROR
      expect{ subject.top_up(amount) }.to raise_error message
    end

    it "should raise error when under minimum balance" do
      message = Oystercard::MINIMUM_BALANCE_ERROR
      expect{ subject.touch_in(station) }.to raise_error message
    end

  end

  describe "#touch_out" do
    before do
      subject.top_up(10)
      allow(journey).to receive_messages(entry_station: nil, start: nil)
      subject.touch_in(station)
    end

    it "should deduct minimum fare from balance" do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end

    it "should append journey to journey_history" do
      subject.touch_out(exit_station)
      expect(subject.journey_history).to eq [journey]
    end
  end


end
