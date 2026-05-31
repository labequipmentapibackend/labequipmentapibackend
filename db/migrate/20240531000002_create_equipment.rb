class CreateEquipment < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment do |t|
      t.string :name, null: false # Required [cite: 9]
      t.string :serial_number, null: false # Required [cite: 10]
      t.string :status, null: false, default: "available" # Default available [cite: 10, 16]
      t.references :category, null: false, foreign_key: true # Foreign key [cite: 10, 15]
      t.timestamps
    end
    add_index :equipment, :serial_number, unique: true # Unique index [cite: 15]
  end
end