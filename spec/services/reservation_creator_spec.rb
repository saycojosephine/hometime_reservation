require 'rails_helper'

RSpec.describe ReservationCreator, type: :model do

  describe '.call' do
    let(:payload) do
      {
        "reservation_code": "YYY999",
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

    subject { described_class.call(payload) }

    describe 'when payload is valid' do
      it 'should have status 200' do
        expect(subject[:status]).to eq(200)
      end
    end

    describe 'when payload is valid' do
      let(:payload) { { test: 'invalid' } }
      it 'should have status 500' do
        expect(subject[:status]).to eq(500)
      end
    end
  end
end
