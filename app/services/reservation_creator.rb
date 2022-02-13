class ReservationCreator
  attr_reader :payload

  def self.call(payload)
    creator = ReservationCreator.new(payload)
    creator.upsert!
  end

  def initialize(payload)
    @payload = JSON.parse(payload.to_json, symbolize_names: true)
  end

  def upsert!
    affiliate = detect_affiliate

    if affiliate
      record = affiliate.upsert!(@payload)
      record_id = record.first['id']
      { success: true, reservation: Reservation.find(record_id), status: 200  }
    else
      raise 'Invalid payload. Please check your inputs.'
    end
  rescue => e
    handle_exception(e)
  end

  private
  def detect_affiliate
    Reservation::AFFILIATES.detect do |klass|
      klass_schema = klass::JSON_SCHEMA
      klass_payload = klass::main_payload(@payload)

      Reservation.valid_payload?(klass_schema, klass_payload)
    end
  end

  def handle_exception(error)
    Rails.logger.error(error.message)
    { success: false, errors: error.message, status: 500 }
  end
end
