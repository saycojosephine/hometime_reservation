module Affiliates
  class Airbnb < Reservation
    JSON_SCHEMA = "#{Rails.root}/app/models/schemas/affiliates/airbnb.json"

    def self.parse(payload)
      AirbnbParser.parse(main_payload(payload))
    end
  end
end
