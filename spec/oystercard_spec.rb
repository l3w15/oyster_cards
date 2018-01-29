require "oystercard"

describe Oystercard do
  subject(:card) { described_class.new }
  subject(:maxxed_card) { described_class.new }
  before do
    maxxed_card.top_up(described_class::CARD_LIMIT)
  end

  it "should have a balance" do
    expect(card.balance).to eq 0
  end

  describe "#top_up" do
    it "should top up the balance by a specified amount" do
      expect { card.top_up 20 }.to change { card.balance }.by 20
    end

    it "should not top up over the card limit" do
      expect { maxxed_card.top_up 1 }.to raise_error "That top up would take you over your card limit of #{described_class::CARD_LIMIT}"
    end
  end

  describe "#in_journey?" do
    it "outputs a true/false return value" do
      expect(card).not_to be_in_journey
    end
  end

  describe "#touch_in" do
    it "should change in_journey? to true" do
      maxxed_card.touch_in
      expect(maxxed_card).to be_in_journey
    end

    it "should raise error if balance is less than the minimum fare" do
      expect { card.touch_in }.to raise_error "Your balance is below the minimum fare of £#{described_class::MINIMUM_FARE}, please top up"
    end
  end

  describe "#touch_out" do
    it "should change in_journey? to false" do
      maxxed_card.touch_in
      maxxed_card.touch_out
      expect(maxxed_card).to_not be_in_journey
    end

    it "should deduct fare" do
      maxxed_card.touch_in
      expect { maxxed_card.touch_out }.to change { maxxed_card.balance }.by -described_class::MINIMUM_FARE
    end
  end
end
