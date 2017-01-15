class AddDisplaySizeColumnToDay < ActiveRecord::Migration
  def change
    add_column :days, :display_size, :integer
  end
end
