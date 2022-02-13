require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  let(:code) { 'YYY12345678' }
  let(:valid_payload) do
    {
       "reservation_code": code,
       "start_date": "2021-04-14",
       "end_date": "2021-04-18",
       "nights": 4,
       "guests": 4,
       "adults": 2,
       "children": 2,
       "infants": 0,
       "status": "accepted",
       "guest": {
          "first_name": "Wayne",
          "last_name": "Woodbridge",
          "phone": "639123456789",
          "email": "wayne_woodbridge@bnb.com"
       },
       "currency": "AUD",
       "payout_price": "4200.00",
       "security_price": "500",
       "total_price": "4700.00"
    }
  end

  describe "POST /create" do
    scenario 'valid reservation attributes from Airbnb' do
      post '/api/v1/reservations', params: valid_payload, as: :json

      expect(response.status).to eq(200)
      parsed_actual = JSON.parse(response.body)
      expect(parsed_actual['reservation']).to include({ "code" => code })
    end

    scenario 'valid reservation should create a new Record' do
      expect{
        post '/api/v1/reservations', params: valid_payload, as: :json
      }.to change(Reservation, :count).by(1)
    end

    scenario 'valid reservation attributes from Booking' do
      post '/api/v1/reservations', params: {
         "reservation": {
            "code": code,
            "start_date": "2021-03-12",
            "end_date": "2021-03-16",
            "expected_payout_amount": "3800.00",
            "guest_details": {
               "localized_description": "4 guests",
               "number_of_adults": 2,
               "number_of_children": 2,
               "number_of_infants": 0
            },
            "guest_email": "wayne_woodbridge@bnb.com",
            "guest_first_name": "Kayne",
            "guest_last_name": "Woodbridge",
            "guest_phone_numbers": [
               "639123456789",
               "639123456789"
            ],
            "listing_security_price_accurate": "500.00",
            "host_currency": "AUD",
            "nights": 4,
            "number_of_guests": 4,
            "status_type": "accepted",
            "total_paid_amount_accurate": "4300.00"
         }
      }, as: :json

      expect(response.status).to eq(200)
      parsed_actual = JSON.parse(response.body)
      expect(parsed_actual['reservation']).to include({ "code" => code })
    end

    scenario 'invalid reservation attributes' do
      post '/api/v1/reservations', params: {
        "invalid": "sample"
      }, as: :json

      expect(response.status).to eq(500)
      parsed_actual = JSON.parse(response.body)
      expect(parsed_actual['status']).to be_falsey
      expect(parsed_actual['errors']).to eq('Invalid payload. Please check your inputs.')
    end

    describe 'when reservation code is already existing' do
      before { ReservationCreator.call(valid_payload) }
      let(:updated_payload) { valid_payload.merge(guests: 5, infants: 1) }

      scenario 'should update the reservation details' do
        post '/api/v1/reservations', params: updated_payload, as: :json

        expect(response.status).to eq(200)
        parsed_actual = JSON.parse(response.body)
        expect(parsed_actual['reservation']).to include({ "guests" => 5, "infants" => 1})
      end
      
      scenario 'should not create a new Reservation record' do
        expect{
          post '/api/v1/reservations', params: updated_payload, as: :json
        }.to change(Reservation, :count).by(0)
      end
    end
  end
end
