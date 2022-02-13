class Reservation < ApplicationRecord
  belongs_to :guest

  AFFILIATES = [ Affiliates::Airbnb, Affiliates::Booking ]

  def self.upsert!(payload)
    parsed_payload = parse(payload)
    guest_payload = parsed_payload.guest
    reservation_payload = parsed_payload.reservation

    Reservation.transaction do
      guest = Guest.upsert(guest_payload, unique_by: :email)
      reservation_payload.merge!(guest_id: guest.first['id'], type: self.name)
      self.upsert(reservation_payload, unique_by: :code)
    end
  end

  def self.main_payload(payload)
    payload
  end

  def self.parse
    raise "You haven't implemented me yet!"
  end

  def self.valid_payload?(schema, payload)
    JSON::Validator.validate(schema, main_payload(payload))
  end
end
