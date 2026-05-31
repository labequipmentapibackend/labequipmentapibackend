class CreateMaintenanceRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :maintenance_records do |t|
      t.text :description, null: false # Required [cite: 12]
      t.datetime :performed_at, null: false # Required [cite: 12]
      t.references :equipment, null: false, foreign_key: true # Foreign key [cite: 12, 16]
      t.timestamps
    end
    add_index :maintenance_records, [:equipment_id, :performed_at] # Composite index [cite: 16]
  end
end