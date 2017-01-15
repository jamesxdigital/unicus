class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.string :date
      t.string :name
      t.integer :column

      t.timestamps null: false
    end
  end
end
