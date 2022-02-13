require 'rails_helper'

RSpec.describe BookingParser do
  let(:code) { 'YYY999' }
  let(:start_date) { '2021-04-14' }
  let(:email) { 'wayne_woodbridge@bnb.com' }
  let(:first_name) { 'Wayne' }

  describe '.parse' do
    let(:payload) do
      {
        code: code,
        start_date: start_date,
        end_date: '2021-03-16',
        expected_payout_amount: 3800.00,
        guest_details: {
           localized_description: '4 guests',
           number_of_adults: 2,
           number_of_children: 2,
           number_of_infants: 0
        },
        guest_email: email,
        guest_first_name: first_name,
        guest_last_name: 'Woodbridge',
        guest_phone_numbers: [
           '639123456789',
           '639123456789'
        ],
        listing_security_price_accurate: 500.00,
        host_currency: 'AUD',
        nights: 4,
        number_of_guests: 4,
        status_type: 'accepted',
        total_paid_amount_accurate: 4300.00
      }
    end

    subject { described_class.parse(payload) }

    it 'should map the data to reservation columns' do
      expect(subject.reservation).to include({
        code: code,
        start_date: start_date
      })
    end

    it 'should map the data to guest columns' do
      expect(subject.guest).to include({
        email: email,
        first_name: first_name
      })
    end
  end
end
