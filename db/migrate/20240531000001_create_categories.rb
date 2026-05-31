class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false # Required [cite: 7]
      t.timestamps
    end
    add_index :categories, :name, unique: true # Unique index [cite: 15]
  end
end