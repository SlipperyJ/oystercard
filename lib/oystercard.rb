require_relative 'station'
require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  attr_accessor :balance, :journey_history_array, :journey, :dummy_journey

  def initialize
    @balance = 0
    @journey_history_array = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    self.balance += amount
  end

  def settle_journey(station = Journey::UNRECORDED_STATION)
    journey.finish_journey(station)
    deduct(journey.fare)
    store_journey
  end

  def touch_in(station)
    sufficient_balance_check?
    settle_journey if journey
    @journey = Journey.new(station)
  end

  def touch_out(station)
    @journey = Journey.new if journey == nil || journey.complete?
    settle_journey(station)
    self.journey = nil
  end

def in_journey?
  !!(journey != nil && !journey.complete?)
end

private

attr_accessor :exit_station, :entry_station
  def store_journey
    self.journey_history_array << journey
  end

  def deduct(amount)
    self.balance -= amount
  end

  def sufficient_balance_check?
    raise "insufficient funds" if balance < MINIMUM_FARE
  end
end
