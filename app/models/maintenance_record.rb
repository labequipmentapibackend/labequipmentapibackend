class MaintenanceRecord < ApplicationRecord
  belongs_to :equipment # Belongs to equipment [cite: 14]

  validates :description, presence: true # Required [cite: 12]
  validates :performed_at, presence: true # Required [cite: 12]
end