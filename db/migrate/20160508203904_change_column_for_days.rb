class ChangeColumnForDays < ActiveRecord::Migration
  def self.up
    change_table :days do |t|
      t.change :column, :string
    end
  end
  def self.down
    change_table :days do |t|
      t.change :column, :integer
    end
  end
end
