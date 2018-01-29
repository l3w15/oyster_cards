class Oystercard
  attr_reader :balance, :entry_station
  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station
  end

  def top_up(amount)
    raise "That top up would take you over your card limit of #{CARD_LIMIT}" if @balance + amount > CARD_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Your balance is below the minimum fare of £#{MINIMUM_FARE}, please top up" if @balance < MINIMUM_FARE
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    @entry_station = nil
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @in_journey
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
