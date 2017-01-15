class ChangeColumnForLectures < ActiveRecord::Migration
  def self.up
    change_table :lectures do |t|
      t.change :column, :string
    end
  end
  def self.down
    change_table :lectures do |t|
      t.change :column, :integer
    end
  end
end
