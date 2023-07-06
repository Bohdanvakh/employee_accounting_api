class Department < ApplicationRecord
  has_many :employees, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 6, maximum: 120 }
  validates :abbreviation, presence: true, length: { minimum: 40, maximum: 400 }

  scope :current_manager, -> {
    joins(employees: { position_histories: :position })
      .where(positions: { name: Position::MANAGER })
      .where(position_histories: { finished_on: nil })
      .order('position_histories.started_on DESC')
      .limit(1)
  }
end
