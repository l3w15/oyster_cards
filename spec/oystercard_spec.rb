require "oystercard"

describe Oystercard do
  it "should have a balance" do
    expect(subject.balance).to eq 0
  end

  describe "#top_up" do
    it "should top up the balance by a specified amount" do
      expect { subject.top_up 20 }.to change { subject.balance }.by 20
    end

    it "should not top up over the card limit" do
      card_limit = described_class::CARD_LIMIT
      subject.top_up(card_limit)
      expect { subject.top_up 1 }.to raise_error "That top up would take you over your card limit of #{card_limit}"
    end
  end

  describe "#deduct" do
    it "should deduct the balance by specified amount" do
      expect { subject.deduct 20 }.to change { subject.balance }.by -20
    end
  end

  describe "#in_journey?" do
    it "outputs a true/false return value" do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#touch_in" do
    it "should change in_journey? to true" do
      subject.touch_in
      expect(subject).to be_in_journey
    end
  end

  describe "#touch_out" do
    it "should change in_journey? to false" do
      subject.touch_in
      subject.touch_out
      expect(subject).to_not be_in_journey
    end
  end
end
