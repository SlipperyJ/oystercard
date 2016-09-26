require_relative 'journey.rb'

class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 1
  PENALTY_CHARGE = 6

  attr_reader :balance, :journey_history


  def initialize
    @balance = 0
    @journey = nil
    @journey_history = []
  end

  def top_up(amount)
    raise 'Maximum amount exceeded' if (balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @journey
  end

  def touch_in(station)
    fail "you need at least £1 to travel" if balance < MIN_BALANCE

    if @journey
      deduct(@journey.fare)
      store_journey
    end

    @journey = Journey.new(station)
  end

  def touch_out(station)
    @journey = Journey.new(nil) unless @journey
    @journey.exit_station = station
    deduct(@journey.fare)
    store_journey
  end

  private

  def store_journey
    @journey_history << @journey
    @journey = nil
  end

  def deduct(amount)
    @balance -= amount
  end
end
