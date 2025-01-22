class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :schedule

  validates :user_id, presence: true
  validates :schedule_id, presence: true



end
