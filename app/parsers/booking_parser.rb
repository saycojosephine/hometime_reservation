class BookingParser
  attr_reader :reservation, :guest

  def self.parse(payload)
    BookingParser.new(payload: payload)
  end

  def initialize(payload: nil)
    @reservation = parse_reservation(payload)
    @guest       = parse_guest(payload)
  end

  private

  def parse_reservation(reservation)
    {
      code: reservation[:code],
      start_date: reservation[:start_date],
      end_date: reservation[:end_date],
      nights: reservation[:nights],
      guests: reservation[:number_of_guests],
      adults: reservation[:guest_details][:number_of_adults],
      children: reservation[:guest_details][:number_of_children],
      infants: reservation[:guest_details][:number_of_infants],
      status: reservation[:status_type],
      currency: reservation[:host_currency],
      payout_price: reservation[:expected_payout_amount],
      security_price: reservation[:listing_security_price_accurate],
      total_price: reservation[:total_paid_amount_accurate]
    }
  end

  def parse_guest(guest)
    { 
      first_name: guest[:guest_first_name],
      last_name: guest[:guest_last_name],
      phone_numbers: guest[:guest_phone_numbers],
      email: guest[:guest_email]
    }
  end
end