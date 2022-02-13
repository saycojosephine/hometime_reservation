require 'rails_helper'

RSpec.describe AirbnbParser do
  let(:code) { 'YYY999' }
  let(:start_date) { '2021-04-14' }
  let(:email) { 'wayne_woodbridge@bnb.com' }
  let(:first_name) { 'Wayne' }

  describe '.parse' do
    let(:payload) {
      {
        reservation_code: code,
        start_date: start_date,
        end_date: '2021-04-18',
        nights: 4,
        guests: 4,
        adults: 2,
        children: 2,
        infants: 0,
        status: 'accepted',
        guest: {
           first_name: first_name,
           last_name: 'Woodbridge',
           phone: '639123456789',
           email: email
        },
        currency: 'AUD',
        payout_price: 4200.00,
        security_price: 500,
        total_price: 4700.00
      }
    }
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
