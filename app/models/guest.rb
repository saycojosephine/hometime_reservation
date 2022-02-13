class Guest < ApplicationRecord
  has_one :reservation
end