class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :sheet
  validates :sheet_id, uniqueness: { scope: [:schedule_id, :date], message: "この座席は既に予約されています" }
  # この上のやつで、schedule_idとdateの組み合わせに対してsheet_idの重複を禁止する
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "は無効な形式です" }
  validates :date, presence: true
end
