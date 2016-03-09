require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:station) {double :station}
  let(:exit_station) {double :exit_station}
  let(:journey) {{:entry_station=>station,:exit_station=>exit_station}}

  describe "initialization" do
    it 'is initialized with a balance of 0' do
      expect(subject.balance).to eq 0
    end

    it "has an empty journey history" do
      expect(subject.journeys).to eq []
    end
  end

  describe "#top_up" do
    it "should top up card by specified amount" do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by(10)
    end

    it "should raise an error if maximum balance exceeded" do
      amount = Oystercard::MAXIMUM_BALANCE + 1
      expect{ subject.top_up(amount) }.to raise_error("Maximum balance exceeded")
    end

    it "should raise error when under minimum balance" do
      expect{ subject.touch_in(station) }.to raise_error "Not enough funds"
    end

  end

  describe "#touch_out" do
    before do
      subject.top_up(10)
      subject.touch_in(station)
    end

    it "should deduct minimum fare from balance" do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end

    it "should append journey to journey_history" do
      subject.touch_out(exit_station)
      expect(subject.journeys).to eq [journey]
    end
  end

  
end
