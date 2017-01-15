class FixLectures < ActiveRecord::Migration
  def change
    rename_column :lectures, :column, :column_name
  end
end
