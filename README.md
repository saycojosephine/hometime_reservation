# README
Rails API with 1 endpoint that accepts multiple payload.

Requirements:
ruby 2.7.4

Setup:
1. Install the gems
  $ bundle install
2. Create the database
  $ rails db:create
3. Run the migration
  $ rails db:migrate
4. Run the application
  $ rails s
  
Run the test:
  $ bundle exec rspec


Endpoint:
POST http://127.0.0.1:3000/api/v1/reservations

Sample payload 1:
{
   "reservation_code":"YYY12345678",
   "start_date":"2021-04-14",
   "end_date":"2021-04-18",
   "nights":4,
   "guests":4,
   "adults":2,
   "children":2,
   "infants":0,
   "status":"accepted",
   "guest":{
      "first_name":"Wayne",
      "last_name":"Woodbridge",
      "phone":"639123456789",
      "email":"wayne_woodbridge@bnb.com"
   },
   "currency":"AUD",
   "payout_price":"4200.00",
   "security_price":"500",
   "total_price":"4700.00"
}

Response:
{
    "success": true,
    "reservation": {
        "id": 19,
        "code": "YYY12345678",
        "start_date": "2021-04-14",
        "end_date": "2021-04-18",
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": "accepted",
        "currency": "AUD",
        "payout_price": "4200.00",
        "security_price": "500",
        "total_price": "4700.00",
        "guest_id": 19,
        "created_at": "2022-02-13T08:08:57.623Z",
        "updated_at": "2022-02-13T08:13:59.270Z"
    }
}

Sample payload 2:
{
   "reservation":{
      "code":"XXX12345678",
      "start_date":"2021-03-12",
      "end_date":"2021-03-16",
      "expected_payout_amount":"3800.00",
      "guest_details":{
         "localized_description":"4 guests",
         "number_of_adults":2,
         "number_of_children":2,
         "number_of_infants":0
      },
      "guest_email":"wayne_woodbridge@bnb.com",
      "guest_first_name":"Kayne",
      "guest_last_name":"Woodbridge",
      "guest_phone_numbers":[
         "639123456789",
         "639123456789"
      ],
      "listing_security_price_accurate":"500.00",
      "host_currency":"AUD",
      "nights":4,
      "number_of_guests":4,
      "status_type":"accepted",
      "total_paid_amount_accurate":"4300.00"
   }
}

Response:
{
    "success": true,
    "reservation": {
        "id": 25,
        "code": "XXX12345678",
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": "accepted",
        "currency": "AUD",
        "payout_price": "3800.00",
        "security_price": "500.00",
        "total_price": "4300.00",
        "guest_id": 19,
        "created_at": "2022-02-13T08:16:10.927Z",
        "updated_at": "2022-02-13T08:16:10.927Z"
    }
}


