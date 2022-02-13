class AirbnbParser
  attr_reader :reservation, :guest

  def self.parse(payload)
    AirbnbParser.new(payload: payload)
  end

  def initialize(payload: nil)
    @reservation = parse_reservation(payload)
    @guest       = parse_guest(payload)
  end

  private

  def parse_reservation(reservation)
    {
      code: reservation[:reservation_code],
      start_date: reservation[:start_date],
      end_date: reservation[:end_date],
      nights: reservation[:nights],
      guests: reservation[:guests],
      adults: reservation[:adults],
      children: reservation[:children],
      infants: reservation[:infants],
      status: reservation[:status],
      currency: reservation[:currency],
      payout_price: reservation[:payout_price],
      security_price: reservation[:security_price],
      total_price: reservation[:total_price]
    }
  end

  def parse_guest(reservation)
    {
      first_name: reservation[:guest][:first_name],
      last_name: reservation[:guest][:last_name],
      phone_numbers: [reservation[:guest][:phone]],
      email: reservation[:guest][:email]
    }
  end
end