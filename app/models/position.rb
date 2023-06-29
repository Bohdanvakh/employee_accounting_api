class Position < ApplicationRecord
  has_many :position_histories, dependent: :destroy
  has_many :employees, through: :position_histories

  MANAGER = "manager"

  validates :name, presence: true, length: { minimum: 4, maximum: 120 }
  validates :salary, presence: true, numericality: { greater_than: 0 }
  validates :vacation_days, presence: true, numericality: { only_integer: true }
end
