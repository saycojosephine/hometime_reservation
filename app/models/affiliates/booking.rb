module Affiliates
  class Booking < Reservation
    JSON_SCHEMA = "#{Rails.root}/app/models/schemas/affiliates/booking.json"

    def self.main_payload(payload)
      payload[:reservation]
    end

    def self.parse(payload)
      BookingParser.parse(main_payload(payload))
    end
  end
end