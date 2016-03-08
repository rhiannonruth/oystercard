require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  it 'is initialized with a balance of 0' do
    expect(oystercard.balance).to eq 0
  end


  describe "#top_up" do
    it "should top up card by specified amount" do
      expect{oystercard.top_up(10)}.to change{oystercard.balance}.by(10)
    end

    it "should raise an error if maximum balance exceeded" do
      amount = described_class::MAXIMUM_BALANCE + 1
      expect{oystercard.top_up(amount)}.to raise_error("Maximum balance exceeded")
    end
  end

  describe "#deduct" do
    it "should deduct the specified amount from balance" do
      expect{oystercard.deduct(10)}.to change{oystercard.balance}.by(-10)
    end
  end

  describe "#in_journey?" do
    it "should display travel status" do
      expect(oystercard).not_to be_in_journey
    end
  end

  describe "#touch_in" do
    it "should change in_journey status to true" do
      oystercard.top_up(10)
      expect{oystercard.touch_in}.to change{oystercard.in_journey?}.to(true)
    end

    it "should raise error when under minimum balance" do
      expect{oystercard.touch_in}.to raise_error "Not enough funds"
    end
  end

  describe "#touch_out" do
    it "should change in_journey status to false" do
      oystercard.top_up(10)
      oystercard.touch_in
      expect{oystercard.touch_out}.to change{oystercard.in_journey?}.to(false)
    end
  end


end
