class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :sheet
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "は無効な形式です" }
  validates :schedule_id, uniqueness: true
  validates :sheet_id, uniqueness: true
  validates :date, presence: true
end
