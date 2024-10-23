class Schedule < ApplicationRecord
  belongs_to :movie
  has_many :reservations
end
