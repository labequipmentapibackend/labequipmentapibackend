class Category < ApplicationRecord
  has_many :equipment, dependent: :restrict_with_error # Prevent delete if equipment exists [cite: 13, 62]
  validates :name, presence: true, uniqueness: true # Required and unique [cite: 7]
end