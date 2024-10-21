# app/models/movie.rb
class Movie < ApplicationRecord
  # 自分で作んなきゃダメだった
  validates :name, presence: true, uniqueness: true
  has_many :schedules
end
