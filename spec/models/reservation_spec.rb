require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it 'is not valid without a code' do
    reservation = described_class.new(status: 'accepted')
    expect(reservation).to_not be_valid
  end
  
  describe '.valid_payload?' do
    subject { described_class.valid_payload?(Affiliates::Airbnb::JSON_SCHEMA, payload) }

    context 'when there are missing data' do
      let(:payload) do
        {
          "reservation": {
            "code": "XXX12345672"
          } 
        }
      end

      it { is_expected.to be_falsey }
    end

    context 'when the data is complete' do
      let(:payload) do
        {
           "reservation_code": "YYY12345678",
           "start_date": "2021-04-14",
           "end_date": "2021-04-18",
           "nights":4,
           "guests":4,
           "adults":2,
           "children":2,
           "infants":0,
           "status": "accepted",
           "guest":{
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

      it { is_expected.to be_truthy }
    end
  end
end
