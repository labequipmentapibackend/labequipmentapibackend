class Equipment < ApplicationRecord
  belongs_to :category # Belongs to category [cite: 13]
  has_many :maintenance_records, dependent: :destroy # Cascades delete [cite: 14, 61]

  validates :name, presence: true # Required [cite: 9]
  validates :serial_number, presence: true, uniqueness: true # Required and unique [cite: 10]
  validates :status, presence: true, inclusion: { in: %w[available in_use maintenance] } # Must be one of [cite: 10]
end