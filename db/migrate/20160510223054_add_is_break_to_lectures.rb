class AddIsBreakToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :is_break, :boolean
  end
end
