class Screen < ApplicationRecord
  has_many :schedules
  validates :name, presence: true
end
