class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys
  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station
    @exit_station
    @journeys = []
  end

  def top_up(amount)
    raise "That top up would take you over your card limit of #{CARD_LIMIT}" if @balance + amount > CARD_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Your balance is below the minimum fare of £#{MINIMUM_FARE}, please top up" if @balance < MINIMUM_FARE
    @entry_station = station
    @exit_station = nil
    @journeys << {:entry_station => station, :exit_station => nil}
  end

  def touch_out(station)
    @entry_station = nil
    @exit_station = station
    @journeys.last[:exit_station] = station
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    !!entry_station
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
